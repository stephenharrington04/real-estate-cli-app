require_relative "../lib/user_inputs.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/listing.rb"
require 'pry'

class CommandLineInterface
  def run
    welcome_message
    search = User_inputs.new
    mod_search_parameters(search) if display_search_parameters(search) == "y"
    listings_query_results(search)
    display_search_results

  end

  def welcome_message
    puts "Welcome to the Real Estate Application!"
  end

  def listings_query_results(user_inputs)
    parsed_criteria = Parser.new(user_inputs)
    criteria_url = Url_creator.new(parsed_criteria)
    listings_array = Scraper.search_results_scraper(criteria_url.url)
    listings_query_results if listings_array.first == "404 Error"
    Listing.create_from_collection(listings_array)
  end

  def display_search_parameters(inputs)
    y_or_n = ""
    puts ""
    puts "These are the search parameters you've entered:"
    inputs.inputs_hash.each {|key, parameter| puts "#{key}:  #{parameter}"}
    puts ""
    puts "Would you like to change any of these parameters?"
    until y_or_n == "y" || y_or_n == "n"
      puts "Please enter 'Y' or 'N'"
      y_or_n = gets.strip.downcase
    end
    y_or_n
  end

  def mod_search_parameters(inputs)
    mod_input = ""
    valid_parameter_types = ["Zip Code", "Min Price", "Max Price", "Bedrooms", "Bathrooms", "Property Type"]
    puts "Which search parameter would you like to modify?"
    until mod_input != ""
      valid_parameter_types.each {|type| print "#{type}"}
      puts ""
      input = gets.strip.downcase
      if valid_parameter_types.include?(input)
        mod_input = input
      else
        puts "Please enter a valid selection from the list below:"
      end
    end
    case mod_input
      when "zip code"
        inputs.zip_code?
      when "min price"
        inputs.min_price?
      when "max price"
        inputs.max_price?
      when "bedrooms"
        inputs.bedrooms?
      when "bathrooms"
        inputs.bathrooms?
      when "property type"
        inputs.property_type?
    end
    inputs
  end

  def display_search_results
    counter = 1
    if Listing.all == []
      puts ""
      puts ""
      puts "No results found.  Please enter new search criteria."
      puts ""
      puts ""
      listings_query_results
    else
      Listing.all.each do |listing|
        puts "(#{counter})"
        puts "   Address: #{listing.address}"
        puts "   Price:  #{listing.price}"
        puts "   # Of Bedrooms:  #{listing.beds}"
        puts "   # Of Bathrooms:  #{listing.baths}"
        puts "   Property Type:  #{listing.property_type}"
        puts "   Listing URL:  #{listing.house_url}"
        counter += 1
      end
    end
  end

  def self.query_mod
    query = ""
    puts "Do you want to start a new search?"
    until query != ""
      puts "Select 'Y' or 'N'"
      input = gets.strip.downcase
      if input == "y" || input == "n"
        query = input
      end
    end
    query
  end

  def self.fine_tune
    puts "For which listing do you want more information?"
    which_listing = gets.strip
  end

  #def second_tier_inputs
  #  num_of_listings = Listing.all.size
  #  if User_inputs.query_mod == "y"
  #    if User_inputs.fine_tune != ["1..#{num_of_listings.to_s}"]
  #      if num_of_listings <= 1
  #        puts "Please enter a number between 1 and #{num_of_listings.to_s}."
  #      else
  #        puts "You can only select 1"
  #      end
  #    else
#
  #end

end
m = CommandLineInterface.new.run
binding.pry
