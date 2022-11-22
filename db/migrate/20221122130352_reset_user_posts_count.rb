class ResetUserPostsCount < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      user.reset_posts_count!
    end
  end
end
