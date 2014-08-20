class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :boolean
  end
end
