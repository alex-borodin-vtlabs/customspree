class AddRentalReturnDateToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :rental_return_date, :datetime
  end
end
