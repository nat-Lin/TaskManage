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
  scope :start_time_sort, -> { order(:start_time) }
  scope :end_time_sort, -> { order(:end_time) }
end
