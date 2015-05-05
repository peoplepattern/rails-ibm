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
    
    watson.followers.limit(50).each do |follower|
      data[:nodes].push(follower.to_node)
      data[:edges].push({source: watson.id, target: follower.id, id: "#{watson.id}:#{follower.id}"})
    end

    render json: data
  end
end
