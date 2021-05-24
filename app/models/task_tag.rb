# == Schema Information
#
# Table name: task_tags
#
#  id         :bigint           not null, primary key
#  task_id    :bigint           not null
#  tag_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaskTag < ApplicationRecord
  belongs_to :task
  belongs_to :tag
end
