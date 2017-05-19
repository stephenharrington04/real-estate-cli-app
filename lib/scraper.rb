require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_reader :index_url

  def initialize(created_url)
    @index_url = created_url.url
  end

  #The index scraper should take in the @index_url as an argument
    #want to scrape:
      #the address
      #the price
      #the beds
      #the baths
      #the sq ft
      #the garage size (1, 2, 3 car garage)
      #the url for the house
  def

  #The home scraper should take in the url for the house created from the index scraper
    #want to scrape:
      #status
      #price/sq ft
      #days on realtor.com
      #year built
      #description




end
