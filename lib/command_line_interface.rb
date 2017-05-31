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
    listings_query_results if listings_array.first == "404 Error"
    Listing.create_from_collection(listings_array)
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
      binding.pry
    end
  end

  def second_tier_inputs
    num_of_listings = Listing.all.size
    if User_inputs.query_mod == "y"
      if User_inputs.fine_tune != ["1..#{num_of_listings.to_s}"]
        if num_of_listings !< 2
          puts "Please enter a number between 1 and #{num_of_listings.to_s}."
        else
          puts "You can only select 1"
        end
      else

  end

end
m = CommandLineInterface.new.run
