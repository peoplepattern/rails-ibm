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
        color: '#c7c39d',
        hover_color: '#C7AE9D',
        size: 3
      })
      friend.friends.limit(100).each do |sub_friend|
        data[:edges].push({
          source: sub_friend.id,
          target: friend.id,
          id: "#{friend.id}:#{sub_friend.id}",
          type: 'curvedArrow',
          color: '#9dc7c3',
          hover_color: '#C7AE9D',
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
end
