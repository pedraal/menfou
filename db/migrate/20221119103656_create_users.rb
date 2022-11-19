class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :auth0_id
      t.json :auth0_data
      t.string :handle

      t.timestamps
    end
  end
end
