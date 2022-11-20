# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  auth0_data   :json
#  fuzzy_handle :string
#  handle       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  auth0_id     :string
#
class User < ApplicationRecord
  validates :handle, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows, source: :followee
  has_many :inverse_follows, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :inverse_follows, source: :follower


  before_validation :set_fuzzy_handle

  def set_fuzzy_handle
    fuzzy_handle = TextCleanerService.clean(handle)
  end
end
