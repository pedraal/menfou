class AddRepliesCountToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :replies_count, :integer, default: 0

    up_only do
      Post.find_each do |post|
        Post.reset_counters(post.id, :replies)
      end
    end
  end
end
