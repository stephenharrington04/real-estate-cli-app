class Url_creator

  def initialize(parsed_inputs)

  end

  #basic url framework:  http://www.realtor.com/realestateandhomes-search/ZIP CODE/BEDS/BATHS/PROPERTY TYPE/PRICE RANGE
  #http://www.realtor.com/realestateandhomes-search/  Must always be present
  #zipcode is the only Required User_input
  #if any of the other variables are nil, then that section will be skipped over/ommitted

  def url_maker
    web_address = "http://www.realtor.com/realestateandhomes-search/"
  end

end
