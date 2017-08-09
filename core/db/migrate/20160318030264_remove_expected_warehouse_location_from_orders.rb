class RemoveExpectedWarehouseLocationFromOrders < ActiveRecord::Migration
  def change
    remove_column :spree_orders, :expected_warehouse_location
  end
end