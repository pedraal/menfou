# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }, index: true
      t.references :followee, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end

    add_index :follows, %i[follower_id followee_id], unique: true
  end
end
