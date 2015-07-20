require File.expand_path('../boot', __FILE__)

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SongXianZhi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :"zh-CN"
    config.i18n.fallbacks = [:en]
    config.i18n.available_locales = [:en, :"zh-CN"]
    config.i18n.enforce_available_locales = false

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
        :view_specs    => false,
        :controller_specs => false,
        :routing_specs => false
    end


    #need fixd
    #  config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # config.assets.precompile += Ckeditor.assets

    config.assets.precompile += ['logo.js']
    config.assets.precompile += [ 'html5shiv-printshiv.min.js', 'respond.min.js', 'ie10-viewport-bug-workaround.js', 'ie-emulation-modes-warning.js']
    config.assets.precompile += ['jquery.iframe-transport.js','jquery.fileupload.js','jquery.fileupload-ui.js']

   #config.assets.precompile += %w(error_code.css error_code.js information.css information2.css information.js information2.js iscroll.css chat.css chat.js)
    #config.autoload_paths += Dir[Rails.root.join('app', 'entities', '*')]
    #config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

    config.action_controller.default_url_options = { host: Settings.host }
    config.action_controller.asset_host = Settings.asset_host

    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'

    config.action_mailer.default_url_options = {host: Settings.host }
    config.action_mailer.raise_delivery_errors = true #改为true，并添加如下内容
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address => Settings.email_address,
        :port => Settings.email_port,
        :domain => Settings.email_domain,
        :authentication => :login,
        :user_name => Settings.email_user_name, #你的邮箱
        :password => Settings.email_password #你的密码
    }

    config.middleware.insert_before "Rack::Runtime", "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any,
                      :methods => [:get, :post, :put, :patch, :options]
      end
    end
 

  end
end
