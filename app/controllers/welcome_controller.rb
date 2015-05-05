class WelcomeController < ApplicationController
  skip_before_filter :verify_authenticity_token
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

  def population
    if params[:ids]
      render json: Post.aggs(params[:ids])
    else
      render json: Post.aggs
    end
  end
end
