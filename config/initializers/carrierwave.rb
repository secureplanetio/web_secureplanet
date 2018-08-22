CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/spec/support/uploads"
  else
    config.root = "#{Dir.home}/planet_root"
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end
