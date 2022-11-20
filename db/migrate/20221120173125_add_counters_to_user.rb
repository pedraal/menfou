class AddCountersToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :posts_count, :integer, default: 0
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :followees_count, :integer, default: 0

    up_only do
      User.find_each do |user|
        User.reset_counters(user.id, :posts)
        User.reset_counters(user.id, :followers)
        User.reset_counters(user.id, :followees)
      end
    end
  end
end
