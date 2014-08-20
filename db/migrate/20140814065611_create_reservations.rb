class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer  :lesson_id
      t.integer  :student_id
      t.integer  :schedule_id
      t.timestamps
    end
  end
end
