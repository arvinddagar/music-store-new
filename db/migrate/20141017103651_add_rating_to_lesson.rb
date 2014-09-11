class AddRatingToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :avg_rate, :integer
  end
end
