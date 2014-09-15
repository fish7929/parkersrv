class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.string :uuid
      t.string :time_range
      t.float :rates
      t.references :information, index: true

      t.timestamps
    end
  end
end
