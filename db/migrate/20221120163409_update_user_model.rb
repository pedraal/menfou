# frozen_string_literal: true

class UpdateUserModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :auth0_data
  end
end
