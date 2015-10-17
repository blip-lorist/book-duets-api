if ENV["RAILS_ENV"] == "test"
  $redis = MockRedis.new
elsif ENV["RAILS_ENV"] == "development"
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end
