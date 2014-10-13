class AddBookedToTiming < ActiveRecord::Migration
  def change
    add_column :timings, :booked, :integer, :default => 0
  end
end
