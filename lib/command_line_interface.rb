require_relative "../lib/user_inputs.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/listing.rb"
require 'pry'

class CommandLineInterface
  def run
    welcome_message
    listings_query_results
    display_search_results
  end

  def welcome_message
    puts "Welcome to the Real Estate Application!"
  end

  def listings_query_results
    search_criteria = User_inputs.new
    parsed_criteria = Parser.new(search_criteria)
    criteria_url = Url_creator.new(parsed_criteria)
    listings_array = Scraper.search_results_scraper(criteria_url.url)
    Listing.create_from_collection(listings_array)
  end

  def display_search_results
    counter = 1
    if Listing.all.first.address == ""
      puts "No results found.  Please enter new search criteria."
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
      binding.pry
    end
  end

end
m = CommandLineInterface.new.run
