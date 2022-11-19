class AddPostUserRelation < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :author, :string

    add_reference(:posts, :user,  foreign_key: true, null: false)
  end
end
