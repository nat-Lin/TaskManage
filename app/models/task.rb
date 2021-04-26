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
#  status     :integer          default(0)
#

class Task < ApplicationRecord
  include ActiveModel::Validations

  enum status: { undone: 0, execute: 1, finish: 2 }

  default_scope { order(:created_at) }
  scope :field_sort, ->(field) { order(field.to_sym) }  
  scope :search_title, ->(keyword) { where('title LIKE ?', "%#{keyword}%") }

  validates :title, :start_time, :end_time, presence: true
  validates_with EndTimeValidator, if: -> { end_time.present? && start_time.present? }

  def self.search_status(status)
    where(status: status == 'all' ? [0, 1, 2] : statuses[status])
  end
end
