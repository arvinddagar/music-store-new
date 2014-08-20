class CreateTimings < ActiveRecord::Migration
  def change
    create_table :timings do |t|
      t.time :start_time
      t.time :end_time
      t.integer :day_id

      t.timestamps
    end
  end
end
