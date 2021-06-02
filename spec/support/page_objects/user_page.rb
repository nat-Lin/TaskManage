require_relative "base"

module PageObjects
  class UserPage < Base
    def run_sign_up(name: 'rspec_test', password: 'password', password_conf: 'password')
      visit 'registers/new'
      within('#user_sign_up') do 
        fill_in User.human_attribute_name(:name), with: name
        fill_in User.human_attribute_name(:password), with: password
        fill_in User.human_attribute_name(:password_confirmation), with: password_conf
      end
      click_button t('users.new.submit')
    end

    def run_sign_in(name, password)
      visit 'session/new'
      within('#user_sign_in') do
        fill_in User.human_attribute_name(:name), with: name
        fill_in User.human_attribute_name(:password), with: password
      end
      click_button t('sessions.new.submit')
    end

    def run_sign_out(name, password)
      run_sign_in(name, password)
      click_link t('layouts.navbar.sign_out')
    end
  end
end