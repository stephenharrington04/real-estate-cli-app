require_relative "../lib/user_inputs.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/listing.rb"
require 'pry'

class CommandLineInterface
  def run
    welcome_message
    inquiry = User_inputs.new
    while display_search_parameters(inquiry) == "y"
      mod_search_parameters(inquiry)
    end
    listings_query_results(inquiry)
    display_search_results
    if query_mod == "1"
      il_url = more_info
      display_individual_listing(il_url)
    elsif query_mod == "2"
      run
    elsif query_mod == "3"
      puts "Thanks for using the Real Estate Application!"
    end
  end

  def welcome_message
    puts "Welcome to the Real Estate Application!"
  end

  def new_beginning
    inquiry = User_inputs.new
    mod_search_parameters(inquiry) if display_search_parameters(inquiry) == "y"
    inquiry
  end

  def listings_query_results(inputs)
    parsed_criteria = Parser.new(inputs)
    criteria_url = Url_creator.new(parsed_criteria)
    if Scraper.checker(criteria_url.url) != "404 Error"
      listings_array = Scraper.search_results_scraper(criteria_url.url)
      Listing.create_from_collection(listings_array)
    else
      listings_query_results(new_beginning)
    end
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
    valid_types = []
    mod_input = ""
    valid_parameter_types = ["Zip Code", "Min Price", "Max Price", "Bedrooms", "Bathrooms", "Property Type"]
    puts "Which search parameter would you like to modify?"
    until mod_input != ""
      puts ""
      valid_parameter_types.each {|type| print "     #{type}"}
      puts ""
      puts ""
      input = gets.strip.downcase
      valid_parameter_types.each {|type| valid_types << type.downcase}
      if valid_types.include?(input)
        mod_input = input
      else
        puts "Please enter a valid selection from the list below:"
      end
    end
    case mod_input
      when "zip code"
        inputs.zip_code = inputs.zip_code?
      when "min price"
        inputs.min_price = inputs.min_price?
      when "max price"
        inputs.max_price = inputs.max_price?
      when "bedrooms"
        inputs.bedrooms = inputs.bedrooms?
      when "bathrooms"
        inputs.bathrooms = inputs.bathrooms?
      when "property type"
        inputs.property_type = inputs.property_type?
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

  def display_individual_listing(url)
    i_listing_hash = Scraper.listing_scraper(url)
    i_listing_hash.each do |key, value|
      case key
        when "address"
          puts "Address:  #{value}"
        when "beds"
          puts "Bedrooms:  #{value}"
        when "baths"
          puts "Bathrooms:  #{value}"
        when "sqft"
          puts "Sqft:  #{value}"
        when "acres"
          puts "Acres:  #{value}"
        when "status"
          puts "Status:  #{value}"
        when "price_per_sqft"
          puts "Price Per Sqft:  #{value}"
        when "days_on_market"
          puts "Days on Markey:  #{value}"
        when "year_built"
          puts "Year Built:  #{value}"
        when "property_type"
          puts "property Type:  #{value}"
        when "description"
          puts "#{value}"
      end
    end
  end

  def query_mod
    query = ""
    puts ""
    puts "Would you like to:"
    puts "(1) Get more information about a listing"
    puts "(2) Start a new search"
    puts "(3) Exit"
    until query == "1" || query == "2" || query == "3"
      puts "Select '1' '2' or '3'"
      input = gets.strip
      if input == "1" || input == "2" || input == "3"
        query = input
      end
    end
    query
  end

  def more_info
    more = ""
    available_numbers = Listing.all.size
    puts "You only have one available listing" if available_numbers == 1
    puts ""
    puts "For which listing do you want more information?"
    until more != ""
      puts "Please select 1 - #{available_numbers.to_s}"
      which_listing = gets.strip.to_i
      if which_listing > 0 && which_listing <= available_numbers
        more = which_listing.to_s
      end
    end
    Listing.all[(more.to_i) - 1].house_url
  end

end
m = CommandLineInterface.new.run
