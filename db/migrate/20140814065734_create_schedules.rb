class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer  :lesson_id
      t.string   :days
      t.time     :start_time
      t.time     :end_time
      t.integer  :no_of_days
      t.timestamps
    end
  end
end
