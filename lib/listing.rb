
class Listing

  attr_accessor address:, price:, beds:, baths:, property_type:, house_url:, sqft:, acres:, status:, price_per_sqft:, days_on_market:, year_built:, description:

  def initialize(listing_hash)
    listing_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.create_from_collection(listings_array)
    listings_array.each {|hash| Listing.new(hash)}
  end

  def self.all
    @@all
  end

end
