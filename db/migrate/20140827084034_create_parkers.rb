class CreateParkers < ActiveRecord::Migration
  def change
    create_table :parkers do |t|
      t.string :garage_name
      t.string :point
      t.integer :total_parking_spaces
      t.integer :remaining_parking_spaces
      t.string :address
      t.float :price
      t.integer :isOpen
      t.string :status
      t.integer :road_garage

      t.timestamps
    end
  end
end
