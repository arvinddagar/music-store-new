class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :lesson
      t.belongs_to :student
      t.timestamps
    end
  end
end
