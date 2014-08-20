class AddTutorIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :tutor_id, :integer
  end
end
