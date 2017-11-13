sidekiq_config = { url: ENV['REDIS_CACHE_URL'], namespace: 'hd_app_#{Rails.env}' }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end