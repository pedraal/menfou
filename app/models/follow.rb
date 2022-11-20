# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_follows_on_followee_id                  (followee_id)
#  index_follows_on_follower_id                  (follower_id)
#  index_follows_on_follower_id_and_followee_id  (follower_id,followee_id) UNIQUE
#
# Foreign Keys
#
#  followee_id  (followee_id => users.id)
#  follower_id  (follower_id => users.id)
#
class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
end
