class AddValueToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :rate, :integer
  end
end
