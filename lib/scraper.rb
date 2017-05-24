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
      #the url for the house
  def index_scraper(index_url)
    house_info = []
    doc = Nokogiri::HTML(open(index_url))
    #doc.css(".properties").css(".row").css(".srp-list").css(".srp-list-marginless").css("li").first.css(".srp-item-body").css(".srp-item-details").css("a.srp-card-anchor-overlay").attribute("href").value
    doc.css(".properties").css(".row").css(".srp-list").css(".srp-list-marginless").css("li").each do |listing|
      house_url = "http://www.realtor.com"
      street_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-street-address").text
      city_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-city").text
      state_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-region").text
      postal_address = listing.css(".srp-item-body").css(".srp-item-address").css(".listing-postal").text
      home_address = "#{street_address} #{city_address}, #{state_address}, #{postal_address}"
      home_price = listing.css(".srp-item-body").css(".srp-item-price").css(".data-price-display").text
      home_num_beds = listing.css(".srp-item-body").css(".srp-item-property-meta").css("ul").css("li").css("span.data-value.meta-beds").text
      #home_num_baths = listing.css(".srp-item-body").css(".srp-item-property-meta").css("ul").css("li")[1].css("span.data-value").text
      #house_url << li.css(".js-record-user-activity.js-navigate-to.srp-item").attr("data-url").value
      #house_url << listing.css(".srp-item-body").css(".srp-item-details").css("a.srp-card-anchor-overlay").attribute("href").value
      house_info << {address: home_address, price: home_price, beds: home_num_beds} if home_address != " , , "
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


  #def self.house_scraper(house_url)
  #  address_info = []
  #  html = open(house_url)
  #  doc = Nokogiri::HTML(html)
#    doc.css #...logic...
#    house_status =
  #  price_sqft =
#    days_active =
#    year_built =
#    description =
#    address_info << {status: house_status, price_per_sqft: price_sqft, days_on_market: days_active, yr_built: year_built, scription: description}
#    address_info
#  end
end
binding.pry
m = Scraper.new
m.index_scraper("http://www.realtor.com/realestateandhomes-search/67037/beds-1/type-single-family-home/price-250000-400000")
