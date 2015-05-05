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
      data[:nodes].push({
                          displayName: "Follower #{i}",
                          label: "Follower #{i}",
                          id: i,
                          size: 1,
                          tid: "id:twitter:22389244",
                          summary: "Interaction Designer @ibmwatson, digital anthropologist, feminist, and game designer. @ITP_NYU alum 2014. Code liberator @codeliberation. Co-creator @facetscon.",
                          image: {url: "https://pbs.twimg.com/profile_images/590939493693140992/z6TaOaH0_normal.jpg"},
                          handle: "carolinesinders",
                          extensions: {
                            location: "new orleans//brooklyn",
                            favorites: 8872,
                            screenName: "carolinesinders",
                            followers: 884,
                            posts: 13230,
                          },
                          displayName: "caroline sinders",
                          objectType: "page",
                          url: "http://t.co/hMDmdQqGEd",
                          "@timestamp" =>  143079012950
                        })
      data[:edges].push({source: 'watson', target: i, id: i})
    end

    render json: data
  end
end
