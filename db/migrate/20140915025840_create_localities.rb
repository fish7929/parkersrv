class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :uuid
      t.string :code
      t.string :parentId
      t.string :name
      t.string :garageNum
      t.integer :level

      t.timestamps
    end
  end
end
