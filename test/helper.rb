require 'rubygems'
require 'test/unit'
require 'shoulda'

begin
  require 'ruby-debug'
rescue LoadError => e
  puts "debugger disabled"
end

ROOT = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'allthumbs')

require File.join(ROOT, 'lib', 'allthumbs.rb')

FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")
