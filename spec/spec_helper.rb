$LOAD_PATH.unshift(File.expand_path('.'))
require 'groundhog_app'
require 'rspec'
require 'capybara/rspec'

Capybara.app = Sinatra::Application

def app
  Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end