class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.string :uuid
      t.string :garage_num
      t.integer :total_parking_number

      t.timestamps
    end
  end
end
