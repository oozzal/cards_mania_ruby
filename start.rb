APP_ROOT = File.dirname(__FILE__)
require "#{APP_ROOT}/init"
require "game"

game = Game.new
system "clear"
puts game.start(ARGV[0])

