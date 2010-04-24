require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'mongo'
require 'mongo/gridfs'
#require File.join(File.dirname(__FILE__), '..', 'lib', 'rack', 'gridfs')
class Upload

  def load_artifact(filename, key, content_type)
    db = Mongo::Connection.new(test_database_options[:hostname], test_database_options[:port]).db(test_database_options[:database])
    GridFS::GridStore.unlink(db, key)
    GridFS::GridStore.open(db, key, 'w', :content_type => content_type) do |dest|
      File.open(File.join(File.dirname(__FILE__), 'artifacts', filename), 'r') do |orig|
        dest.puts orig.read
      end
    end
  end
  
  def options_for_gridfs
    { :hostname => 'myhostname.mydomain', :port => 8765, :database => 'mydatabase', :prefix => 'myprefix' }
  end
  
  def stub_mongodb_connection
    Rack::GridFS.any_instance.stubs(:connect!).returns(true)
  end
  
  def test_database_options
    { :hostname => 'localhost', :port => 27017, :database => 'test', :prefix => 'gridfs' }
  end

end

#Upload.new.load_artifact('3wolfmoon.jpg', 'images/3wolfmoon.jpg', 'image/jpeg')
#Upload.new.load_artifact('fun1.jpg', 'images/a.jpg', 'image/jpeg')
#Upload.new.load_artifact('ebay', 'images/ebay.pdf', '')
#Upload.new.load_artifact('test.txt', 'images/test', 'text/plain')
#Upload.new.load_artifact('test.html', 'images/test.html', 'text/html')
Upload.new.load_artifact('sbtn2.gif', 'images/zone.gif', 'image/gif')
