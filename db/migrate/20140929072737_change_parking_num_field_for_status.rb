class ChangeParkingNumFieldForStatus < ActiveRecord::Migration
  def change
		change_column :statuses, :parking_num, :integer
  end
end
