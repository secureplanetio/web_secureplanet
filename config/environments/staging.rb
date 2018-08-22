Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false

  ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: AppConfig.host }
  config.action_mailer.default_options = { from: Settings.email.from }

  ActionMailer::Base.smtp_settings = {
    user_name: Settings.email.username,
    password: Settings.email.password,
    domain: Settings.email.domain,
    address: Settings.email.address,
    port: Settings.email.port,
    authentication: Settings.email.authentication,
    enable_starttls_auto: Settings.email.enable_starttls_auto,
  }
end
