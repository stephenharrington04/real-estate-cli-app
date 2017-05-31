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
    Scraper.search_results_scraper(criteria_url.url)
  end

  def display_search_results
    listings_array = listings_query_results
    listings_array.each do |listing_hash|
      listing_hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end
    binding.pry
  end

end
m = CommandLineInterface.new.display_search_results
