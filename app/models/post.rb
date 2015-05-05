class Post
  OPTIONS = {}#{basic_auth: {username: ENV['ES_USER'], password: ENV['ES_PASS']}}

  # returns posts by a user id
  def self.find_by_unique_id(id)
    blob = OPTIONS
    blob[:body] = {query:{term: {"actor.id" => id}},sort: {published: {order: "desc"}}}
    return self.parse_list(self.request(blob))
  end

  # sends a request blob hash to the elastic database and returns the parsed result
  def self.request(blob)
    blob[:body][:size] = 50 if blob[:body][:size].nil? # default to 100 objects come back
    blob[:body] = blob[:body].to_json
    puts blob[:body]
    return JSON.parse(HTTParty.post('http://watson.peoplepattern.com:9200/ibmwatson_activity_2/activity/_search', blob).body)
  end

 def self.parse_list(raw)
    parsed = {total: raw['hits']['total'], posts: []}
    parsed = self.parse_profiles(raw, parsed)

    return parsed
  end

  # parses out the profile data from an elastic response and formats it for returning
  def self.parse_profiles(raw, parsed)
    parsed[:posts] ||= []
    raw['hits']['hits'].each do |hit|
      parsed[:posts] << hit['_source']
    end
    return parsed
  end

end
