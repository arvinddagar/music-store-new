class AddStripeTokenToReservations < ActiveRecord::Migration
  def change
      add_column :reservations, :stripe_customer_token, :string
      add_column :reservations, :card_token, :string
      add_column :reservations, :timing_id, :integer
  end
end
