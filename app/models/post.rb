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
  validates :body, length: { maximum: 280 }

  belongs_to :user

  after_create_commit { broadcast_prepend }
  after_update_commit { broadcast_replace }
  after_destroy_commit { broadcast_destroy }

  def broadcast_prepend
    broadcastables.each do |broadcastable|
      broadcast_prepend_to broadcastable
    end
  end

  def broadcast_replace
    broadcastables.each do |broadcastable|
      broadcast_replace_to broadcastable
    end
  end

  def broadcast_destroy
    broadcastables.each do |broadcastable|
      broadcast_remove_to broadcastable
    end
  end

  def broadcastables
    broadcastables = []
    broadcastables << "#{ActionView::RecordIdentifier.dom_id(user)}-posts"
      broadcastables << "posts-for-#{ActionView::RecordIdentifier.dom_id(user)}"
      user.followers.each do |follower|
      broadcastables << "posts-for-#{ActionView::RecordIdentifier.dom_id(follower)}"
    end

    broadcastables
  end
end
