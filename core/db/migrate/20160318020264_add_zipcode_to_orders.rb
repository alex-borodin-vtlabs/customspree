class AddZipcodeToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :zipcode, :string
  end
end
