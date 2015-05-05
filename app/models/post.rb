class Post
  OPTIONS = {}#{basic_auth: {username: ENV['ES_USER'], password: ENV['ES_PASS']}}

  # returns posts by a user id
  def self.find_by_unique_id(id)
    blob = OPTIONS
    blob[:body] = {query:{term: {"actor.id" => id.gsub("id:twitter:","")}},sort: {published: {order: "desc"}}}
    blob = self.apply_keywords_agg(blob)
    return self.parse_list(self.request(blob))
  end

  # sends a request blob hash to the elastic database and returns the parsed result
  def self.request(blob)
    blob[:body][:size] = 50 if blob[:body][:size].nil? # default to 100 objects come back
    blob[:body] = blob[:body].to_json
    puts blob[:body]
    return JSON.parse(HTTParty.post('http://watson.peoplepattern.com:9200/ibmwatson_activity_18/activity/_search', blob).body)
  end

  def self.apply_keywords_agg(blob)
     blob[:body][:aggs] ||= {}
     blob[:body][:aggs][:top_keywords] = {
       terms: {field: "extensions.alchemykeywords.keywords.text", size: 10},
       aggs: {sentiment:{terms:{field: "extensions.alchemykeywords.keywords.sentiment.type"}}}
     }

     return blob
  end

 def self.parse_list(raw)
    parsed = {total: raw['hits']['total'], posts: []}
    parsed = self.parse_profiles(raw, parsed)
    parsed = self.parse_keywords(raw, parsed)

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

  def self.parse_keywords(raw, parsed)
    if raw['aggregations'] && raw['aggregations']['top_keywords']
      parsed[:top_keywords] = raw['aggregations']['top_keywords']['buckets'].map do |bucket|
        top_s = bucket['sentiment']['buckets'][0]['key']
        {key: bucket['key'], doc_count: bucket['doc_count'], sentiment: top_s}
      end
    end
    parsed
  end

end
