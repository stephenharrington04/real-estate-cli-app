
class Url_creator

  attr_reader :search_criteria, :url

  def initialize(parsed_inputs)
    @search_criteria = parsed_inputs.search_parameters
    @url = self.url_maker
  end

  def url_maker
    web_address = "https://www.realtor.com/realestateandhomes-search/#{self.search_criteria[:zip]}"
    parameters = ["bedrooms", "bathrooms", "prop_type", "price_range"]
    parameters.each do |parameter|
      self.search_criteria.each do |key, value|
        web_address << "/#{value}" if parameter == key.to_s
      end
    end
    web_address
  end

end
