require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
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

        # Do not swallow errors in after_commit/after_rollback callbacks.
        config.active_record.raise_in_transactional_callbacks = true
        
        
        
        # 想重载jbuilder的templates但是感觉他好像把templates的路径写死了,最后没折腾出来,然后把他整个generator搬了出来
        # lib/generator/rails/custom_jbuilder
        # 给他替换了orz
        config.generators do |g|
            g.stylesheets false
            g.javascripts :custom_coffee
            g.helper :model_config
            g.jbuilder :custom_jbuilder
        end

        
        # 将各个model的配置载入内存
        # 每个model的配置主要是针对前端的dataTable的设置
        # 比如visiable,searchable,orderable,formatter等
        config.model_config=Hash.new
        Dir.entries(Rails.root.join('config', 'model_config').to_s).each do |filename|
            unless File.directory?(filename)
                name=filename[/(\w+).yml$/,1]
                config.model_config[name]=config_for "model_config/#{name}"
            end
        end

        
        # devise需要
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    end
end
