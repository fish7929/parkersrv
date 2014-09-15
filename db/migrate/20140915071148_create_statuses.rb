class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :uuid
      t.string :garage_num
      t.string :parking_num
      t.string :rom_num
      t.string :status

      t.timestamps
    end
  end
end
