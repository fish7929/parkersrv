class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uuid
      t.string :rom_num
      t.string :event
      t.datetime :last_time

      t.timestamps
    end
  end
end
