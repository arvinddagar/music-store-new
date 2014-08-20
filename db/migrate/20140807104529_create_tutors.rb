class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :user_name
      t.integer  :user_id
      t.text     :about_me
      t.text     :skills
      t.text     :teaching_philosophy
      t.integer  :duration
      t.text     :credentials_and_affiliations
      t.string   :age_group
      t.string   :instruments
      t.string   :experience
      t.text     :description
      t.timestamps
    end
  end
end
