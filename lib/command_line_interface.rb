class CommandLineInterface
  def run

  end

  def listings_query_results
    search_criteria = User_inputs.new
    parsed_criteria = Parser.new(search_criteria)
    criteria_url = Url_creator.new(parsed_criteria)
    query_results = Scraper.search_results_scraper(criteria_url)
  end

end
