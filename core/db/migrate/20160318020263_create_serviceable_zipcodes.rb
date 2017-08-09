class CreateServiceableZipcodes < ActiveRecord::Migration
  def change
    create_table :spree_serviceable_zipcodes, force: true do |t|
      t.references :stock_location
      t.string :zipcode

      t.timestamps
    end

    add_index :spree_serviceable_zipcodes, :stock_location_id
    add_index :spree_serviceable_zipcodes, :zipcode, unique: true
  end
end
