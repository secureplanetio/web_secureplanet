Rails.application.config.middleware.use(
  RackPassword::Block,
  auth_codes: [AppConfig.server_access_password],
  path_whitelist: /\d+|oauth/,
) if Rails.env == 'staging'
