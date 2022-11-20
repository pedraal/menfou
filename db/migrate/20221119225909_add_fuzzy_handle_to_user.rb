# frozen_string_literal: true

class AddFuzzyHandleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fuzzy_handle, :string

    up_only do
      User.find_each do |user|
        user.update!(fuzzy_handle: User.cleanHandle(user.handle))
      end
    end
  end
end
