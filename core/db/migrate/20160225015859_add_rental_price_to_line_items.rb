class AddRentalPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :rental_price, :decimal, precision: 10, scale: 2
  end
end
