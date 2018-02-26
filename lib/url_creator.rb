class Url_creator

  attr_reader :parsed_parameters_hash, :url

  def initialize(parsed_parameters_hash)
    @parsed_parameters_hash = parsed_parameters_hash
    @url = self.url_maker
  end

  def url_maker
    web_address = "https://www.realtor.com/realestateandhomes-search/#{self.parsed_parameters_hash[:parsed_zip_code]}"
    parameters = ["parsed_bedrooms", "parsed_bathrooms", "parsed_property_type", "parsed_price_range"]
    parameters.each do |parameter|
      self.parsed_parameters_hash.each do |key, value|
        web_address << "/#{value}" if parameter == key.to_s && value != nil
      end
    end
    web_address
  end

end
