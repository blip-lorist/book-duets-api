if Rails.env.test?
  $redis = MockRedis.new
elsif Rails.env.development?
  $redis = Redis.new(:host => 'localhost', :port => 6379)
elsif Rails.env.production?
  $redis = Redis.new(:url => ENV['REDIS_URL'])
end
