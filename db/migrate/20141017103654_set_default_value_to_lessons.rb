class SetDefaultValueToLessons < ActiveRecord::Migration
  def change
  	change_column :lessons, :avg_rate, :integer, :default => 0
  end
end
