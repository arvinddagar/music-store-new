class AddDetailsToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :user_name, :string
    add_column :students, :address, :string
  end
end
