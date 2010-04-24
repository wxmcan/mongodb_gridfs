require 'rubygems'
require 'sinatra'

require 'rack/gridfs'
use Rack::GridFS, :hostname => 'localhost', :port => 27017, :database => 'test', :prefix => 'gridfs'

get /.*/ do
"Whatchya talking about?"
end

