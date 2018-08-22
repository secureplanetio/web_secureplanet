Rollbar.configure do |config|
  config.access_token = AppConfig.rollbar_server_key
  config.enabled = false if Rails.env.test? || Rails.env.development?
  config.environment = ENV['ROLLBAR_ENV'] || Rails.env
end
