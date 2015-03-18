class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.string :query
      t.text :data
      t.integer :total

      t.timestamps null: false
    end
  end
end
