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
  def index_scraper(index_url)
    house_info = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry
    doc.css(".properties").css(".row").css(".srp-list").css(".srp-list-marginless").css("li").each do |li|
    first.css(".srp-item-body")
      #.css("div.page-content").css("div.container-srp").css("div.srp-body").css("div.container srp-card-wrapper").css("div.row js-sticky-container").css("section.col-lg-9 col-md-8 srp-list-column").css("div.srp-list margin-top").css("div").css("ul.srp-list-marginless list-unstyled").css("li").each do |li|
      house_url = "http://www.realtor.com"
      home_address = []
      home_address << li.css(".srp-item-body").css(".srp-item-address").css(".listing-street-address").text
      home_address << li.css(".srp-item-body").css(".srp-item-address").css(".listing-city").text
      home_address << li.css(".srp-item-body").css(".srp-item-address").css(".listing-region").text
      home_address << li.css(".srp-item-body").css(".srp-item-address").css(".listing-postal").text
      home_address.join
      home_price = li.css(".srp-item-body").css(".srp-item-price").css(".data-price-display").text
      home_num_beds = li.css()
      home_num_baths = li.css("data-baths").text
      home_sqft =
      home_garage =
      house_url << li.css(".srp-item-body").css("a").attribute("href").value
      house_info << {address: home_address, price: home_price, beds: home_num_beds, baths: home_num_baths, sqft: home_sqft, garage: home_garage, url: house_url}

    end
    house_info
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

m = Scraper.new
m.index_scraper("http://www.realtor.com/realestateandhomes-search/67037/beds-1/type-single-family-home/price-250000-400000")
