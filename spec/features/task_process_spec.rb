require 'rails_helper'

RSpec.feature 'TaskProcesses', type: :feature do
  background(:all) do
    @user = create(:user)
    @task_page = PageObjects::TaskPage.new
  end
  
  background do
    PageObjects::UserPage.new.run_sign_in(@user.name, @user.password)
  end

  describe '任務創建' do
    scenario '從任務檢視頁面按下新增任務應前往任務創建頁面' do
      @task_page.go_to_new_task_page
      expect(page).to have_current_path new_task_path
      expect(page).to have_content t('tasks.new.title')
    end

    scenario '任務創建頁面應該有 title, notes, start_name, end_time, status, priority 欄位' do
      @task_page.go_to_new_task_page
      run_check_form_elements(@task_page)
    end

    scenario '任務創建成功後應在任務檢視頁面顯示創建成功訊息' do
      @task_page.run_create_task(build(:task))
      expect(page).to have_current_path task_path(Task.last.id)
      expect(page).to have_content t('tasks.controller.create_successful')
    end

    scenario '任務創建失敗後應返回創建頁面並使用 new 畫面渲染' do
      @task_page.run_create_task(build(:task, :empty))
      expect(page).to have_current_path tasks_path
      expect(page).to have_content t('tasks.new.title')
    end

    scenario '任務標題、開始時間及結束時間欄位空白時應顯示錯誤訊息' do
      @task_page.run_create_task(build(:task, :empty))
      expect(page).to have_content t('errors.messages.blank'), count: 3
    end

    scenario '任務標題超過限制字數應顯示錯誤訊息' do
      @task_page.run_create_task(build(:task, :long_title))
      expect(page).to have_content t('errors.messages.too_long', count: 50)
    end

    scenario '開始時間及結束時間不合理時應顯示錯誤訊息' do
      @task_page.run_create_task(build(:task, :unreasonable))
      expect(page).to have_content t('tasks.model.error.end_time_not_valid')
    end

    scenario '從任務創建頁面按下返回任務列表應返回任務檢視頁面' do
      visit 'tasks/new'
      click_link t('tasks.view.return_tasks_list')
      expect(page).to have_current_path tasks_path
      expect(page).to have_content t('tasks.index.title')
    end
  end

  describe '任務檢視' do
    given!(:task_list) { create_list(:task, 20, user: @user) }
    given!(:task) { task_list.sample }

    scenario '任務檢視應顯示使用者任務' do
      task_titles = @user.tasks.limit(10).pluck(:title)
      visit 'tasks'
      page_titles = all('tbody>tr>td>a.task-title').map(&:text)
      expect(task_titles).to match_array page_titles
    end

    scenario '任務檢視單頁顯示最大量應是 10 筆' do
      visit 'tasks'
      page_task_count = all('tbody>tr').count
      expect(page_task_count).to eq 10
    end

    scenario '從任務檢視頁面按下任務標題應前往詳細任務頁面' do
      visit 'tasks'
      click_link task.title
      expect(page).to have_current_path task_path(task)
      expect(page).to have_content task.title
    end

    scenario '從詳細任務頁面按下返回任務列表應返回任務檢視頁面' do
      visit task_path(task)
      click_link t('tasks.view.return_tasks_list')
      expect(page).to have_current_path tasks_path
      expect(page).to have_content t('tasks.index.title')
    end
  end

  describe '任務搜索' do
    
  end

  describe '任務修改' do 
    given!(:task) { create(:task, user: @user) }

    scenario '從詳細任務頁面按下修改任務應前往編輯任務頁面' do
      visit task_path(task)
      click_link t('tasks.show.edit_task')
      expect(page).to have_current_path edit_task_path(task)
      expect(page).to have_content t('tasks.edit.title')
    end
    
    scenario '編輯任務頁面應該有 title, notes, start_name, end_time, status, priority 欄位' do
      visit edit_task_path(task)
      run_check_form_elements(@task_page)
    end

    scenario '編輯任務頁面應有當前編輯任務內容' do
      visit edit_task_path(task)
      # expect(page).to have_field(Task.human_attribute_name(:title), with: task.title)
      # expect(page).to have_field(Task.human_attribute_name(:notes), with: task.notes)
      # expect(page).to have_field(Task.human_attribute_name(:start_time), with: task.start_time.strftime('%FT%T'))
      # expect(page).to have_field(Task.human_attribute_name(:end_time), with: task.end_time.strftime('%FT%T'))
      # expect(page).to have_select(Task.human_attribute_name(:statuses), selected: t("tasks.model.statuses.#{task.status}"))
      # expect(page).to have_select(Task.human_attribute_name(:priorities), selected: t("tasks.model.priorities.#{task.priority}"))
      @task_page.form_elements.each do |element|
        field = element[:field]
        expect_obj = 
          if element[:method] == :have_select
            send(element[:method], element[:locator], selected: t("tasks.model.#{field.to_s.pluralize}.#{task.send(field)}"))
          elsif [:start_time, :end_time].include?(field)
            send(element[:method], element[:locator], with: task.send(field).strftime('%FT%T'))
          else
            send(element[:method], element[:locator], with: task.send(field))
          end
        expect(page).to expect_obj
      end
    end

    scenario '更新任務成功後應在詳細任務頁面顯示更新成功訊息' do
      
    end

    scenario '更新任務失敗後應返回編輯頁面並使用 edit 頁面渲染' do
    
    end

    scenario '修改任務標題、開始時間及結束時間為空白時應顯示錯誤訊息' do
      
    end

    scenario '修改任務標題字數超過限制字數應顯示錯誤訊息' do
    
    end

    scenario '修改開始時間及結束時間為不合理時應顯示錯誤訊息' do
    
    end

    scenario '從編輯任務頁面按下返回任務應返回詳細任務頁面' do
      
    end
  end
 
  describe '任務刪除' do
    scenario '從任務列表頁面按下刪除時應跳出重複確定視窗' do
      
    end

    scenario '刪除任務成功後應在任務列表頁面顯示刪除成功訊息' do
      
    end

    scenario '刪除任務後在任務列表不應出現' do
      
    end
  end


  def run_check_form_elements(task_page)
    task_page.form_elements.each do |element|
      expect_obj = 
        if element[:method] == :have_select
          send(element[:method], element[:locator], options: element[:options], selected: element[:selected])
        else
          send(element[:method], element[:locator])
        end
      expect(page).to expect_obj
    end
  end
end
