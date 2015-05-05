class Page
  include Neo4j::ActiveNode

  has_many :in, :followers, type: 'follow', class_name: 'Page', model_class: 'Page'

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
end
