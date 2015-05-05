class WelcomeController < ApplicationController
  def index
  end

  def data
    data = {
      edges: [
              {
                source: 1,
                target: 2,
                id: 3,
              },
              {
                source: 1,
                target: 3,
                id: 4,
              },
              {
                source: 1,
                target: 4,
                id: 6,
              },
              {
                source: 3,
                target: 4,
                id: 7,
              },
             ],
      nodes: [
              {
                name: 'test',
                label: 'test',
                id: 1,
                size: 1,
              },
              {
                name: 'test2',
                label: 'test2',
                id: 2,
                size: 2,
              },
              {
                name: 'test3',
                label: 'test3',
                id: 3,
                size: 3,
              },
              {
                name: 'test4',
                label: 'test4',
                id: 4,
                size: 4,
              },
             ],
    }
    
    render json: data
  end
end
