if Rails.env.test?
  $redis = MockRedis.new
elsif Rails.env.development?
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end
