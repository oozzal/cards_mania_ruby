require_relative '../init.rb'
require 'factory_girl'
require 'factories.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end