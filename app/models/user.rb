# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(30)       not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default("user")
#
class User < ApplicationRecord
  before_destroy :verify_last_user

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  has_secure_password
  has_many :tasks, dependent: :delete_all
  has_many :tags, dependent: :delete_all

  enum role: { user: 0, admin: 1 }

  def verify_last_user
    if User.count == 1
      errors.add(:destroy, I18n.t('activerecord.errors.messages.destroy'))
      throw(:abort)
    end
  end
end
