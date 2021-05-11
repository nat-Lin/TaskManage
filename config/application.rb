require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaskManage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # setup I18n
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :"zh-TW"
    config.i18n.available_locales = [:"zh-TW"]

    # setup time zone
    config.time_zone = 'Taipei'

    # load lib
    config.eager_load_paths += Dir[Rails.root.join('lib', '**/')]

    config.action_view.field_error_proc = proc do |html_tag, instance|
      if html_tag.include?('input')
        html_tag += %{<div class="invalid-feedback">#{instance.error_message.join(', ')}</div>}.html_safe
      end
      html_tag.gsub("form-control", "form-control is-invalid").html_safe

    end
  end
end
