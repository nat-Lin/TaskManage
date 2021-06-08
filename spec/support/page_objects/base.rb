module PageObjects
  class Base
    include Capybara::DSL
    include ActionView::Helpers::TranslationHelper
    include Rails.application.routes.url_helpers
  end
end