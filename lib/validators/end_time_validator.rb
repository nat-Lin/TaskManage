class EndTimeValidator < ActiveModel::Validator
  def validate(record)
    unless record.end_time > record.start_time
      record.errors.add(:end_time, I18n.t('tasks.model.error.end_time_not_valid'))
    end
  end
end