# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  body          :string           not null
#  replies_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parent_id     :integer
#  user_id       :integer          not null
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
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
