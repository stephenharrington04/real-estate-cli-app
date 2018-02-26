require_relative '../config/environment'

start_app = CommandLineInterface.new
puts ""
puts "--------------------------------------------".colorize(:blue)
puts "|  WELCOME TO THE REAL ESTATE APPLICATION  |".colorize(:blue)
puts "--------------------------------------------".colorize(:blue)
start_app.run
