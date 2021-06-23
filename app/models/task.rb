# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  title      :string(50)       not null
#  notes      :text
#  start_time :datetime
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("undone")
#  priority   :integer          default("urgent")
#  user_id    :bigint
#

class Task < ApplicationRecord
  include ActiveModel::Validations

  enum status: { undone: 0, execute: 1, finish: 2 }
  enum priority: { urgent: 0, ordinary: 1, noturgent: 2 }

  default_scope { order(created_at: :desc) }
  scope :field_sort, ->(field) { 
    if priorities.keys.include?(field)
      reorder(Arel.sql(priorities_val_sort(field).map{ |num| "priority=#{num} DESC" }.join(', ')))
    else
      reorder("#{field.to_sym} DESC") 
    end
  }  
  scope :search_title, ->(keyword) { where('title LIKE ?', "%#{keyword}%") }
  scope :search_status, ->(val) { 
    where(status: val == 'all' ? statuses.values : statuses[val])
  }
  scope :search_tag, ->(keyword) { joins(:tags).where('tags.name LIKE ?', keyword)}

  validates :title, :start_time, :end_time, presence: true
  validates :title, length: {maximum: 50}
  validates_with EndTimeValidator, if: -> { end_time.present? && start_time.present? }

  belongs_to :user
  has_many :task_tags
  has_many :tags, through: :task_tags, dependent: :destroy

  def self.priorities_val_sort(key)
    key_num = priorities[key.to_sym]
    original_sort = priorities.values
    original_sort.delete(key_num)
    original_sort.unshift(key_num)
  end
end
