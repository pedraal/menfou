# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_parent_id  (parent_id)
#  index_posts_on_user_id    (user_id)
#
# Foreign Keys
#
#  parent_id  (parent_id => posts.id)
#  user_id    (user_id => users.id)
#
class Post < ApplicationRecord
  validates :body, presence: true
  validates :body, length: { maximum: 280 }

  belongs_to :user
  belongs_to :parent, optional: true, class_name: 'Post'
  has_many :replies, class_name: 'Post', foreign_key: 'parent_id', dependent: :destroy

  after_create_commit do
    broadcast_prepend
    user.increment(:posts_count) unless parent_id
  end
  after_update_commit { broadcast_replace }
  after_destroy_commit do
    broadcast_destroy
    user.decrement(:posts_count) unless parent_id
  end

  scope :replies, -> { where.not(parent_id: nil) }
  scope :not_replies, -> { where(parent_id: nil) }

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

    if parent_id
      broadcastables << "#{ActionView::RecordIdentifier.dom_id(parent)}-replies"
    else
      broadcastables << "#{ActionView::RecordIdentifier.dom_id(user)}-posts"
      broadcastables << "posts-for-#{ActionView::RecordIdentifier.dom_id(user)}"
      user.follower_users.each do |user|
        broadcastables << "posts-for-#{ActionView::RecordIdentifier.dom_id(user)}"
      end

    end

    broadcastables
  end
end
