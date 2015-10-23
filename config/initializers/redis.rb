if Rails.env.test?
  $redis = MockRedis.new
elsif Rails.env.development?
  $redis = Redis.new(:host => 'localhost', :port => 6379)
elsif Rails.env.production?
  $redis = Redis.new(:host => ENV['REDIS_URL'],
  :port => 17319)
end
