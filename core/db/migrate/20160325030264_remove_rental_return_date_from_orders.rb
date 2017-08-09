class RemoveRentalReturnDateFromOrders < ActiveRecord::Migration
  def change
    remove_column :spree_orders, :rental_return_date
  end
end