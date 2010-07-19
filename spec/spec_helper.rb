require 'rubygems'

$:.unshift(File.join(File.dirname(__FILE__), %w[.. lib]))

require 'rack-time-zone-header'
require 'spec/expectations'
require 'rack/test'
