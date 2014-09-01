class AddFeaturedToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :featured, :boolean, default: false
  end
end