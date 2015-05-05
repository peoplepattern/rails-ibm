class Page
  include Neo4j::ActiveNode

  has_many :in, :followers, type: 'follow', class_name: 'Page', model_class: 'Page'
  has_many :out, :friends, type: 'follow', class_name: 'Page', model_class: 'Page'

  id_property :id
  property :displayName
  property :summary
  property :handle
  property :url
  property :'image.url'
  property :'extensions.location'
  property :'extensions.favorites'
  property :'extensions.screenName'
  property :'extensions.followers'
  property :'extensions.posts'
  
  def self.mapped_label_name
    'page'
  end

  def image_url
    self.attributes['image.url']
  end
  
  def location
    self.attributes['extensions.location']
  end
  
  def favorites
    self.attributes['extensions.favorites']
  end
  
  def screen_name
    self.attributes['extensions.screenName']
  end
  
  def display_name
    self.displayName
  end
  
  def followers_count
    self.attributes['extensions.followers']
  end

  def posts
    self.attributes['extensions.posts']
  end

  def to_node
    {
      displayName: self.display_name,
      label: self.display_name,
      id: self.id,
      size: Math.log(self.followers_count),
      tid: self.id,
      summary: self.summary,
      image: {url: self.image_url},
      handle: self.screen_name,
      extensions: {
        location: self.location,
        favorites: self.favorites,
        screenName: self.screen_name,
        followers: self.followers_count,
        posts: self.posts,
      },
      objectType: "page",
      url: self.url,
    }
  end
end
