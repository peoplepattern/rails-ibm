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
      data[:edges].push({
        source: follower.id,
        target: watson.id,
        id: "#{watson.id}:#{follower.id}",
        type: 'arrow',
        color: '#c7c39d',
        hover_color: '#9dc7c3',
        size: 3
      })
    end

    render json: data
  end

  def posts
    posts = Post.find_by_unique_id(params[:id])
    render json: posts
  end
end
