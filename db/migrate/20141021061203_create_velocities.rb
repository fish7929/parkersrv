class CreateVelocities < ActiveRecord::Migration
  def change
    create_table :velocities do |t|
      t.string :uuid
      t.string :garage_num
      t.float :t_8am
      t.float :t_9am
      t.float :t_10am
      t.float :t_11am
      t.float :t_12pm
      t.float :t_1pm
      t.float :t_2pm
      t.float :t_3pm
      t.float :t_4pm
      t.float :t_5pm
      t.float :t_6pm
      t.float :t_7pm
      t.float :t_8pm
      t.float :t_9pm
      t.float :t_10pm_8am

      t.timestamps
    end
  end
end
