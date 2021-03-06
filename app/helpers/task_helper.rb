module TaskHelper
  def options_for_statuses_index
    options_for_select(
      options_for_statuses.unshift([i18n_t_model('.statuses.all'), 'all']),
      options_default(:statuses)
    )
  end

  def options_for_statuses
    Task.statuses.keys.map { |key|
      [i18n_t_model(".statuses.#{key}"), key]
    }
  end

  def options_for_sort
    options = [
      [Task.human_attribute_name(:start_time), 'start_time'],
      [Task.human_attribute_name(:end_time), 'end_time'],
      [Task.human_attribute_name(:created_at), 'created_at']
    ] + options_for_priorities

    options_for_select(options, options_default(:sort))
  end

  def options_for_priorities
    Task.priorities.keys.map { |key|
      [i18n_t_model(".priorities.#{key}"), key]
    }
  end

  def options_for_tag
    current_user.tags.map { |tag|
      [tag.name, tag.name]
    }
  end

  def options_default(obj_name)
    search = params[:search]
    search && search[obj_name] 
  end

  def form_come_back_link(task = nil)
    if ['edit', 'update'].include? action_name 
      link_to t('tasks.edit.return_task'), task_path(task), class: 'btn btn-outline-secondary mx-1'
    else
      link_to t('tasks.view.return_tasks_list'), tasks_path, class: 'btn btn-outline-secondary mx-1'
    end
  end

  private
    def i18n_t_model(key)
      I18n.t("#{key}", scope: 'tasks.model')
    end
end
