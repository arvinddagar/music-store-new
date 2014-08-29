class AddTutorIdToEarning < ActiveRecord::Migration
  def change
    add_column :earnings, :tutor_id, :integer
  end
end