sidekiq_config = { host: 'redis',  port: 6379 }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

