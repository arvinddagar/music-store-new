class CreateEarnings < ActiveRecord::Migration
  def change
    create_table :earnings do |t|
      t.string  :amount
      t.string  :commission
      t.integer :reservation_id
      t.timestamps
    end
  end
end
