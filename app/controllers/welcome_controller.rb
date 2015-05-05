class WelcomeController < ApplicationController
  def index
  end

  def data
    data = {
      nodes: [
              {
                label: 'IBM Watson',
                id: 'watson',
                size: 1,
              },
             ],
      edges: [
             ],
    }
    
    20.times do |i|
      data[:nodes].push({label: "Follower #{i}", id: i, size: 1})
      data[:edges].push({source: 'watson', target: i, id: i})
    end

    render json: data
  end
end
