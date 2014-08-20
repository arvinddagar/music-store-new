class AddLessonIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :lesson_id, :integer
  end
end
