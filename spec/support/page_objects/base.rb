module PageObjects
  class Base
    include Capybara::DSL
    include ActionView::Helpers::TranslationHelper
  end
end