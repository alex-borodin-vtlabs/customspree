class AddRentalStartAndEndDatesToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :rental_start_date, :datetime
    add_column :spree_orders, :rental_end_date, :datetime
  end
end
