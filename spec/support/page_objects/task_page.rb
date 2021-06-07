require_relative 'base'

module PageObjects
  class TaskPage < Base
    def go_to_new_task_page
      visit 'tasks'
      click_link t('tasks.index.create_task')
    end

    def form_elements
      statuses = Task.statuses.keys.map{|key| t("tasks.model.statuses.#{key}")}
      priorities = Task.priorities.keys.map{|key| t("tasks.model.priorities.#{key}")}
      [:title, :notes, :start_time, :end_time].map do |field|
        {
          method: :have_field,
          locator: Task.human_attribute_name(field),
          field: field
        }
      end.push({
          method: :have_select,
          locator: Task.human_attribute_name(:statuses),
          field: :status,
          options: statuses,
          selected: statuses.first
        },{
          method: :have_select,
          locator: Task.human_attribute_name(:priorities),
          field: :priority,
          options: priorities,
          selected: priorities.first
        }
      )
    end

    def run_create_task(task_object)
      visit 'tasks/new'
      within('#new_task') do
        fill_in Task.human_attribute_name(:title), with: task_object.title
        fill_in Task.human_attribute_name(:start_time), with: task_object.start_time
        fill_in Task.human_attribute_name(:end_time), with: task_object.end_time
      end
      click_button t('tasks.form.submit.new')
    end

  end
end