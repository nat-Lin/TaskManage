require "rails_helper"

RSpec.feature 'User Authentication', type: :feature do 
  background(:all) do
    @password = 'password'
    @diff_password = 'diff_password'
    @user_page = PageObjects::UserPage.new
  end
  
  background do
    @user = create(:user)
  end

  describe '使用者註冊' do
    scenario '在註冊之後應在登入頁面顯示註冊成功的訊息' do
      @user_page.run_sign_up(build(:user))
      expect(page).to have_current_path new_session_path
      expect(page).to have_content t('users.controllers.create_successful')
    end

    scenario '註冊失敗後應返回註冊頁面並使用 new 畫面渲染' do
      @user_page.run_sign_up(@user)
      expect(page).to have_current_path registers_path
      expect(page).to have_content '註冊帳號'
    end

    scenario '帳號及密碼欄位空白應顯示錯誤訊息' do
      @user_page.run_sign_up(build(:user, :empty))
      expect(page).to have_content t('errors.messages.blank'), count: 2
    end

    scenario '帳號重複及密碼與密碼確認不一致應顯示錯誤訊息' do
      @user_page.run_sign_up(@user, password_conf: @diff_password)
      expect(page).to have_content t('errors.messages.taken')
      expect(page).to have_content t('errors.messages.confirmation', attribute: User.human_attribute_name(:password))
    end
  end

  describe '使用者登入' do
    scenario '在登入之後應在任務管理頁面顯示登入成功的訊息' do
      @user_page.run_sign_in(@user.name, @password)
      expect(page).to have_current_path root_path
      expect(page).to have_content t('sessions.controllers.create_successful', user: @user.name)
    end
    
    scenario '在登入失敗後應顯示登入失敗的訊息' do
      @user_page.run_sign_in(@user.name, @diff_password)
      expect(page).to have_content t('sessions.controllers.create_failed')
    end
  end
  
  describe '使用者登出' do
    scenario '在登出之後應在登入頁面顯示登出成功的訊息' do 
      @user_page.run_sign_out(@user.name, @password)
      expect(page).to have_current_path new_session_path
      expect(page).to have_content t('sessions.controllers.destroy_successful')
    end
  end
end