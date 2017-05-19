require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  #The index scraper should take in the @index_url as an argument
    #want to scrape:
      #the address
      #the price
      #the beds
      #the baths
      #the sq ft
      #the garage size (1, 2, 3 car garage)
      #the url for the house
  def self.index_scraper(index_url)
    home_info = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".properties show ").css("div .page-content").css("div .container-srp").css("div .srp-body").css("div .container srp-card-wrapper").css("div .row js-sticky-container").css("section .col-lg-9 col-md-8 srp-list-column").css("div .srp-list margin-top").css("div").css("ul .srp-list-marginless list-unstyled").css("li").each do |li|
      home_address =
      home_price =
      home_num_beds =
      home_num_baths =
      home_sqft =
      home_garage =
      home_url =
      home_info << {address: home_address, price: home_price, beds: home_num_beds, baths: home_num_baths, sqft: home_sqft, garage: home_garage, url: home_url}
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




end
