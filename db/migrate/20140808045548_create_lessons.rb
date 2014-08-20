class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string  :name
      t.text    :description
      t.integer :category_id
      t.string  :neighbourhood
      t.string  :address
      t.string  :phone_no
      t.string  :price
      t.integer :duration
      t.boolean :publish
      t.integer :maximum_people
      t.timestamps
    end
  end
end
