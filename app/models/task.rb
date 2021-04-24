# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  title      :string
#  notes      :text
#  start_time :datetime
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ApplicationRecord
  include ActiveModel::Validations

  scope :start_time_sort, -> { order(:start_time) }
  scope :end_time_sort, -> { order(:end_time) }

  validates :title, :start_time, :end_time, presence: true
  validates_with EndTimeValidator, if: -> { end_time.present? && start_time.present? }
end
