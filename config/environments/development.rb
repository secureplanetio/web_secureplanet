Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  ActionMailer::Base.delivery_method = :smtp

  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  config.log_level = :debug
  Rails.logger = Logger.new File.open(File.join(Rails.root, 'tmp', 'secureplanet.log'), 'a')
  config.log_formatter = Logger::Formatter.new

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true
end
