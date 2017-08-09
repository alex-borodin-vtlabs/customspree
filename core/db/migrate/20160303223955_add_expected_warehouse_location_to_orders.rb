class AddExpectedWarehouseLocationToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :expected_warehouse_location, :string
  end
end
