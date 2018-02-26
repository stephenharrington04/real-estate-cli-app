
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

  def display_search_results
    counter = 1
    if self.all == []
      puts ""
      puts ""
      puts "No results found.  Please enter new search criteria.".colorize(:red)
      puts ""
      puts ""
      engine
    else
      self.all.each do |listing|
        puts "(#{counter})".colorize(:light_blue)
        puts "   Address:".colorize(:light_blue) + "  #{self.address ||= "Information not provided"}"
        puts "   Price:".colorize(:light_blue) + "  #{self.price ||= "Information not provided"}"
        puts "   # Of Bedrooms:".colorize(:light_blue) + "  #{self.beds ||= "Information not provided"}"
        puts "   # Of Bathrooms:".colorize(:light_blue) + "  #{self.baths ||= "Information not provided"}"
        puts "   Sqft:".colorize(:light_blue) + "  #{self.sqft ||= "Information not provided"}"
        puts "   Listing URL:".colorize(:light_blue) + "  #{self.house_url ||= "Information not provided"}"
        counter += 1
      end
    end
  end

  def display_individual_listing
    puts "Address:".colorize(:light_blue) + "  #{self.address ||= "Information not provided"}"
    puts "Price:".colorize(:light_blue) + "  #{self.price ||= "Information not provided"}"
    puts "Status:".colorize(:light_blue) + "  #{self.status ||= "Information not provided"}"
    puts "Year Built:".colorize(:light_blue) + "  #{self.year_built ||= "Information not provided"}"
    puts "Days on Market:".colorize(:light_blue) + "  #{self.days_on_market ||= "Information not provided"}"
    puts "# Of Bedrooms:".colorize(:light_blue) + "  #{self.beds ||= "Information not provided"}"
    puts "# of Bathrooms:".colorize(:light_blue) + "  #{self.baths ||= "Information not provided"}"
    puts "Square Feet (livable):".colorize(:light_blue) + "  #{self.sqft ||= "Information not provided"}"
    puts "Acres / Sqft (property):".colorize(:light_blue) + "  #{self.acres ||= "Information not provided"}"
    puts "Price per SqFt:".colorize(:light_blue) + "  #{self.price_per_sqft ||= "Information not provided"}"
    puts "Property Type:".colorize(:light_blue) + "  #{self.property_type ||= "Information not provided"}"
    puts "Listing URL:".colorize(:light_blue) + "  #{self.house_url ||= "Information not provided"}"
    puts "Description:".colorize(:light_blue) + "  #{self.description ||= "Information not provided"}"
  end

end
