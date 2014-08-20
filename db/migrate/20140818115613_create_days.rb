class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :name
      t.integer :schedule_id

      t.timestamps
    end
  end
end
