# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default("user")
#
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password
  has_many :tasks

  enum role: { user: 0, admin: 1, superadmin: 2 }
end
