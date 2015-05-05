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
                displayName: 'test',
                label: 'test',
                id: 1,
                size: 1,
              },
              {
                displayName: 'test2',
                label: 'test2',
                id: 2,
                size: 2,
              },
              {
                displayName: 'test3',
                label: 'test3',
                id: 3,
                size: 3,
              },
              {
                displayName: 'test4',
                label: 'test4',
                id: 4,
                size: 4,
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
                "@timestamp" =>  1430790129500
              },
             ],
    }
    
    render json: data
  end
end
