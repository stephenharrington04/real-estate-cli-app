require 'bundler/setup'
Bundler.require(:default)
require 'open-uri'
require 'pry'
require 'nokogiri'
require 'colorize'
require_relative "../lib/search_parameters.rb"
require_relative "../lib/formatter.rb"
require_relative "../lib/url_creator.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/listing.rb"
require_relative "../lib/command_line_interface.rb"
