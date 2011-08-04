$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'date'
require 'apoptosis/apoptosis.rb'

module Apoptosis
  VERSION = '0.0.4'
end
