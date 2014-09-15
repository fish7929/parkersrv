class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :uuid
      t.string :garage_name
      t.integer :total_parking_space
      t.integer :position
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
