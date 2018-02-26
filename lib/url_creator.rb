class Url_creator

  attr_reader :parsed_parameters_hash, :url

  def initialize(parsed_parameters_hash)
    @parsed_parameters_hash = parsed_parameters_hash
    @url = self.url_maker
  end

  parsed_parameters = {
    parsed_zip_code: search_parameters.zipcode,
    parsed_bedrooms: bedrooms_parse(search_parameters),
    parsed_bathrooms: bathrooms_parse(search_parameters),
    parsed_property_type: property_type_parse(search_parameters),
    parsed_price_range: price_parse(search_parameters)
  }
  end

  def url_maker
    web_address = "https://www.realtor.com/realestateandhomes-search/#{self.parsed_parameters_hash[:parsed_zip_code]}"
    self.parsed_parameters_hash.each do |key, value|
      web_address << "#{value}"
    end
    web_address << parsed_parameters.parsed_bedrooms if parsed_parameters.bedrooms
    web_address << parsed_parameters.parsed_bathrooms if parsed_parameters.bathrooms
    web_address << parsed_parameters.parsed_property_type if parsed_parameters.parsed_property_type
    web_address << parsed_parameters.parsed_price_range if parsed_parameters.parsed_price_range
  end

end
