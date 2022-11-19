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

  def avatar
    "https://source.boringavatars.com/beam/120/#{ERB::Util.url_encode handle}?colors=264653,2a9d8f,e9c46a,f4a261,e76f51"
  end
end
