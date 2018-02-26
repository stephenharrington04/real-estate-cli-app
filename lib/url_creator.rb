class Url_creator
  def self.url_maker(formatted_parameters_hash)
    web_address = "https://www.realtor.com/realestateandhomes-search/#{formatted_parameters_hash[:formatted_zip_code]}"
    parameters = ["formatted_bedrooms", "formatted_bathrooms", "formatted_property_type", "formatted_price_range"]
    parameters.each do |parameter|
      formatted_parameters_hash.each do |key, value|
        web_address << "/#{value}" if parameter == key.to_s && value != nil
      end
    end
    web_address
  end
end
