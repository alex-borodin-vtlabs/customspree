class AddIsRentableToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :is_rentable, :boolean, default: false
  end
end
