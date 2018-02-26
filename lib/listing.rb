
class Listing
  attr_accessor :address, :price, :beds, :baths, :sqft, :acres, :status, :price_per_sqft, :days_on_market, :property_type, :year_built, :style, :description, :house_url
  @@all =[]

  def initialize(listing_hash)
    listing_hash.each {|key, value| self.send("#{key}=", value) if value != ""}
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

  def self.display_search_results
    counter = 1
    if all == []
      puts ""
      puts ""
      puts "No results found.  Please enter new search criteria.".colorize(:red)
      puts ""
    else
      puts ""
      puts "    -----------------------------".colorize(:green)
      puts "    | DISPLAYING SEARCH RESULTS |".colorize(:green)
      puts "    -----------------------------".colorize(:green)
      all.each do |listing|
        puts ""
        puts "(#{counter})".colorize(:light_blue)
        puts "   Address:".colorize(:light_blue) + "  #{listing.address ||= "Information not provided"}"
        puts "   Price:".colorize(:light_blue) + "  #{listing.price ||= "Information not provided"}"
        puts "   # Of Bedrooms:".colorize(:light_blue) + "  #{listing.beds ||= "Information not provided"}"
        puts "   # Of Bathrooms:".colorize(:light_blue) + "  #{listing.baths ||= "Information not provided"}"
        puts "   Sqft:".colorize(:light_blue) + "  #{listing.sqft ||= "Information not provided"}"
        puts "   Listing URL:".colorize(:light_blue) + "  #{listing.house_url ||= "Information not provide"}"
        counter += 1
      end
    end
  end

  def self.display_individual_listing(listing)
    puts "Address:".colorize(:light_blue) + "  #{listing.address ||= "Information not provided"}"
    puts "Price:".colorize(:light_blue) + "  #{listing.price ||= "Information not provided"}"
    puts "Status:".colorize(:light_blue) + "  #{listing.status ||= "Information not provided"}"
    puts "Year Built:".colorize(:light_blue) + "  #{listing.year_built ||= "Information not provided"}"
    puts "Days on Market:".colorize(:light_blue) + "  #{listing.days_on_market ||= "Information not provided"}"
    puts "# Of Bedrooms:".colorize(:light_blue) + "  #{listing.beds ||= "Information not provided"}"
    puts "# of Bathrooms:".colorize(:light_blue) + "  #{listing.baths ||= "Information not provided"}"
    puts "Square Feet (livable):".colorize(:light_blue) + "  #{listing.sqft ||= "Information not provided"}"
    puts "Acres / Sqft (property):".colorize(:light_blue) + "  #{listing.acres ||= "Information not provided"}"
    puts "Price per SqFt:".colorize(:light_blue) + "  #{listing.price_per_sqft ||= "Information not provided"}"
    puts "Property Type:".colorize(:light_blue) + "  #{listing.property_type ||= "Information not provided"}"
    puts "Listing URL:".colorize(:light_blue) + "  #{listing.house_url ||= "Information not provided"}"
    puts "Description:".colorize(:light_blue) + "  #{listing.description ||= "Information not provided"}"
  end

end
