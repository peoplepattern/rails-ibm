class Influence
  def self.score(id)
    if Thread.current[:influence_scores].nil?
      response = Neo4j::Session.query('MATCH (v:page)-[:follow]-(x:page) WITH v.handle as vhandle, x.`extensions.followers` as fcount, x.`extensions.posts` as pcount, x.`extensions.favorites` as favcount, v.id as vid, v.`extensions.followers` as vfcount, x.`extensions.favorites` + x.`extensions.posts` as activity, COUNT(*) as connections RETURN DISTINCT vid,vhandle,FLOOR(1+((2+log(vfcount+1))*(.1+connections*log(2+connections))*(.1+log(2+percentileDisc(fcount,.5)/sqrt(vfcount+1)))*(.1+log(2+percentileDisc(activity,.1))))/25) as score ORDER BY score')
    
      scores = {}
      response.each do |value|
        scores[value.vid] = value.score.to_i
      end
      Thread.current[:influence_scores] = scores
    end
    
    Thread.current[:influence_scores][id]
  end
end
