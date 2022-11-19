# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Post < ApplicationRecord
  validates :user_id, :body, presence: true
  validates :body, length: { maximum: 140 }

  belongs_to :user

  after_create_commit { broadcast_prepend_to "posts" }
  after_update_commit { broadcast_replace_to "posts" }
  after_destroy_commit { broadcast_remove_to "posts" }

  def relative_created_at
    created_at_from_now = Time.current - created_at
    if created_at_from_now < 1.minute
      "#{(created_at_from_now / 1.second).to_i}sec."
    elsif created_at_from_now < 1.hour
      "#{(created_at_from_now / 1.minute).to_i}min."
    elsif created_at_from_now < 1.day
      "#{(created_at_from_now / 1.hour).to_i}h."
    else
      "#{(created_at_from_now / 1.day).to_i}j."
    end
  end
end
