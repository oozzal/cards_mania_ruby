# For test
APP_ROOT = File.dirname(__FILE__) if !defined? APP_ROOT

#'$:' contains array of all the folders to look for files
$:.unshift("#{APP_ROOT}/app")
$:.unshift("#{APP_ROOT}/lib")

# Development requirements
require 'pry'

# My modified String class
require 'string'

requires_dir = ["app", "lib"]
#Get all the directories from the requires array
requires_dir.each do |require_dir|
  Dir.glob("#{APP_ROOT}/#{require_dir}/**/*/").each do |dir|
    $:.unshift(dir)
  end
end
# Initialize game settings and configurations
Dir.glob("#{APP_ROOT}/config/initializers/*.rb").each {|init| load init }
