puts 'REDIS_URL'
puts ENV['REDIS_URL']
# redis_connection = Redis.new(host: "localhost", port: 6379)
# => #<Redis client v3.1.0 for redis://127.0.0.1:6379/0>
puts $redis_connection
$redis = Redis::Namespace.new(:ns, :redis => Redis.new)
# => #<Redis::Namespace v1.5.0 with client v3.1.0 for redis://127.0.0.1:6379/0/ns>