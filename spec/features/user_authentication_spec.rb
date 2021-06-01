require "rails_helper"

RSpec.feature 'User Authentication', type: :feature do 
  scenario '在註冊之後應該顯示註冊成功的訊息' do
    def user_t(key)
      I18n.t(key, scope: 'users')
    end

    visit 'registers/new'
    within('#user_sign_up') do 
      fill_in User.human_attribute_name(:name), with: 'rspec_test'
      fill_in User.human_attribute_name(:password), with: 'password'
      fill_in User.human_attribute_name(:password_confirmation), with: 'password'
    end
    click_button user_t('.new.submit')
    expect(page).to have_content user_t('.controllers.create_successful')
  end

  scenario '在登入之後應該顯示登入成功的訊息' do
    user = create(:user, password: 'test_password')
    
    visit 'session/new'
    within('#user_sign_in') do
      fill_in User.human_attribute_name(:name), with: user.name
      fill_in User.human_attribute_name(:password), with: 'test_password'
    end
    click_button t('sessions.new.submit')
    expect(page).to have_content I18n.t('sessions.controllers.create_successful', user: user.name)
  end

  scenario '在登出之後應該顯示登出成功的訊息' do 
    user = create(:user, password: 'test_password')

    visit 'session/new'
    within('#user_sign_in') do
      fill_in User.human_attribute_name(:name), with: user.name
      fill_in User.human_attribute_name(:password), with: 'test_password'
    end
    click_button t('sessions.new.submit')
    click_link t('layouts.navbar.sign_out')
    expect(page).to have_content I18n.t('sessions.controllers.destroy_successful')
  end
end