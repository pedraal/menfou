# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  followees_count :integer          default(0)
#  followers_count :integer          default(0)
#  fuzzy_handle    :string
#  handle          :string
#  posts_count     :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth0_id        :string
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
