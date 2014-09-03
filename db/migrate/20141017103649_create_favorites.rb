class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :tutor
      t.belongs_to :student
      t.timestamps
    end
  end
end
