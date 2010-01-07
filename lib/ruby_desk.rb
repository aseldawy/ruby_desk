require 'rubygems'
require 'json'

module RubyDesk
end

Dir.glob(File.join(File.dirname(__FILE__), 'ruby_desk', '*.rb')).each do |file|
  require file
end
