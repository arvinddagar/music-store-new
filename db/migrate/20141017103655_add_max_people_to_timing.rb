class AddMaxPeopleToTiming < ActiveRecord::Migration
  def change
    add_column :timings, :max_people, :integer
    # add_column :earnings, :tutor_id, :integer
  end
end
