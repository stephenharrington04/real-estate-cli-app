
class Listing
  attr_accessor :address, :price, :beds, :baths, :sqft, :acres, :status, :price_per_sqft, :days_on_market, :property_type, :year_built, :style, :description, :house_url
  @@all =[]

  def initialize(listing_hash)
    listing_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.create_from_collection(listings_array)
    listings_array.each {|hash| Listing.new(hash)}
  end

  def add_listing_attributes(attributes_hash)
    attributes_hash.each do |key, value|
       self.send("#{key}=", value)
     end
    self
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all = []
  end

end
