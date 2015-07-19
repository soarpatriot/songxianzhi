CarrierWave.configure do |config|
  config.storage = :file
  config.asset_host = Settings.asset_host
end
