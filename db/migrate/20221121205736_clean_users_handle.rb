class CleanUsersHandle < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      user.save!
    end
  end
end
