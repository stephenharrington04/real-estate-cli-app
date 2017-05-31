
class Listing

  def intialize(listings_hash)
    listings_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.all
    @@all
  end



end
