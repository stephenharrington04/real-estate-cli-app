require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  #The index scraper should take in an index_url as an argument
    #want to scrape:
      #the address
      #the price
      #the beds
      #the baths
      #the sq ft
      #the garage size (1, 2, 3 car garage)
      #the url for the house
  def self.index_scraper(index_url)
    house_info = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".properties show ").css("div.page-content").css("div.container-srp").css("div.srp-body").css("div.container srp-card-wrapper").css("div.row js-sticky-container").css("section.col-lg-9 col-md-8 srp-list-column").css("div.srp-list margin-top").css("div").css("ul.srp-list-marginless list-unstyled").css("li").each do |li|
      home_address =
      home_price = li.css("data-price").text
      home_num_beds = li.css()
      home_num_baths = li.css("data-baths").text
      home_sqft =
      home_garage =
      house_url =
      house_info << {address: home_address, price: home_price, beds: home_num_beds, baths: home_num_baths, sqft: home_sqft, garage: home_garage, url: house_url}
      binding.pry
    end
    home_info
  end

  #The home scraper should take in the url for the house created from the index scraper
    #want to scrape:
      #status
      #price/sq ft
      #days on realtor.com
      #year built
      #description

  def self.house_scraper(house_url)
    address_info = []
    html = open(house_url)
    doc = Nokogiri::HTML(html)
    doc.css #...logic...
    house_status =
    price_sqft =
    days_active =
    year_built =
    description =
    address_info << {status: house_status, price_per_sqft: price_sqft, days_on_market: days_active, yr_built: year_built, scription: description}
    address_info
  end




end
