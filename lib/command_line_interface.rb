require_relative "../lib/user_inputs.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/listing.rb"
require 'pry'

class CommandLineInterface
  def run
    listings_query_results

  end

  def listings_query_results
    search_criteria = User_inputs.new
    parsed_criteria = Parser.new(search_criteria)
    criteria_url = Url_creator.new(parsed_criteria)
    listings_array = Scraper.search_results_scraper(criteria_url.url)
    Listing.create_from_collection(listings_array)
  end

  def display_search_results
    counter = 0
    Listing.all.each do |listing|
      puts "(#{counter})"
      puts "   Address: #{address}"
      puts "   Price:  #{price}"
      counter += 1
    end
    binding.pry
  end

  #address: listing_address, price: listing_price, beds: listing_num_beds, baths: listing_num_baths, property_type: listing_prop_type, house_url: listing_url

end
m = CommandLineInterface.new.display_search_results
