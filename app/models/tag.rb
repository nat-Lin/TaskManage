# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(20)       not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  belongs_to :user
  has_many :task_tags
  has_many :tasks, through: :task_tags
end
