class AddClassDateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :class_date, :date
  end
end
