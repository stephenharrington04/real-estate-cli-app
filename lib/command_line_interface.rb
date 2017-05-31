require_relative "../lib/user_inputs.rb"
require_relative "../lib/parser.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
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
    results.each do |listing|
      puts "#{key}: #{value}"
    end
    binding.pry
  end

end
m = CommandLineInterface.new.display_search_results
