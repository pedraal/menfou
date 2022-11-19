# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  auth0_data :json
#  handle     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  auth0_id   :string
#
class User < ApplicationRecord
  validates :handle, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
end
