module TaskHelper
  def option_for_statuses_for_index
    option_for_statuses.unshift([t('tasks.model.statuses.all'), 'all'])
  end

  def option_for_statuses
    Task.statuses.keys.map { |key|
      [t("tasks.model.statuses.#{key}"), key]
    }
  end
end
