class RemoveCredAndAffAndAddCre < ActiveRecord::Migration
  def change
    remove_column :tutors, :credentials_and_affiliations, :text
    add_column :tutors, :cre, :text
  end
end
