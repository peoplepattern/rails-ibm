class WelcomeController < ApplicationController
  def index
  end

  def data
    watson = Page.find('id:twitter:29735775')
    
    data = {
      nodes: [],
      edges: [],
    }
    
    data[:nodes].push(watson.to_node)
    
    nodes = watson.friends.limit(100)
    nodes.each do |friend|
      data[:nodes].push(friend.to_node)
      data[:edges].push({
        source: watson.id,
        target: friend.id,
        id: "#{watson.id}:#{friend.id}",
        type: 'arrow',
        color: '#66757f',
        hover_color: '#BE1931',
        size: 3
      })
      friend.friends.limit(100).each do |sub_friend|
        data[:edges].push({
          source: sub_friend.id,
          target: friend.id,
          id: "#{friend.id}:#{sub_friend.id}",
          type: 'curvedArrow',
          color: '#8899a6',
          hover_color: '#BE1931',
          size: 1
        }) if nodes.map(&:id).include? sub_friend.id
      end
    end

    render json: data
  end

  def posts
    posts = Post.find_by_unique_id(params[:id])
    render json: posts
  end

  def entity
    @entity = JSON.parse(HTTParty.get("http://watson.peoplepattern.com:9200/disambiguated/disambiguated/#{URI::escape(params[:id])}").body)['_source'].symbolize_keys
    @entity[:extended] = {}
    
    if @entity[:dbpedia]
      doc = Nokogiri::HTML(HTTParty.get(@entity[:dbpedia]))
      url = doc.css('link[rel=alternate][type="text/plain"]').first['href']
      
      require 'rdf/ntriples'
      graph = RDF::Graph.load(url)

      graph.each_statement do |statement|
        Rails.logger.info statement.predicate
        
        property = statement.predicate.to_s
        if property =~ /http:\/\/dbpedia.org\//
          label = property.gsub(/^.*\//, '').underscore.humanize
        else
          next
        end

        value = statement.object.to_s

        if value =~ /http:\/\/dbpedia.org\/resource/
          value = value.gsub('http://dbpedia.org/resource/', '').gsub('_', ' ')
        end
        
        @entity[:extended][label] ||= []
        @entity[:extended][label].push(value)
      end
    end
  end
    
  def population
    render json: Post.aggs
  end
end
