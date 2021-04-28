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
#  status     :integer          default("undone")
#  priority   :integer          default("urgent")
#

class Task < ApplicationRecord
  include ActiveModel::Validations

  enum status: { undone: 0, execute: 1, finish: 2 }
  enum priority: { urgent: 0, ordinary: 1, noturgent: 2}

  default_scope { order(created_at: :desc) }
  scope :field_sort, ->(field) { reorder("#{field.to_sym} DESC") }  
  scope :search_title, ->(keyword) { where('title LIKE ?', "%#{keyword}%") }
  scope :search_status, ->(status) { 
    where(status: status == 'all' ? [0, 1, 2] : statuses[status])
  }

  validates :title, :start_time, :end_time, presence: true
  validates_with EndTimeValidator, if: -> { end_time.present? && start_time.present? }
end
