begin
north_america = Spree::Zone.find_by_name!("North America")
rescue ActiveRecord::RecordNotFound
  puts "Couldn't find 'North America' zone. Did you run `rake db:seed` first?"
  puts "That task will set up the countries, states and zones required for Spree."
  exit
end

shipping_category = Spree::ShippingCategory.find_or_create_by!(name: 'Default')

Spree::ShippingMethod.create!([
  {
    :name => "Door-to-Door Delivery",
    :zones => [north_america],
    :calculator => Spree::Calculator::Shipping::FlatRate.create!,
    :shipping_categories => [shipping_category]
  }
])

{
  "Door-to-Door Delivery" => [0, "USD"]
}.each do |shipping_method_name, (price, currency)|
  shipping_method = Spree::ShippingMethod.find_by_name!(shipping_method_name)
  shipping_method.calculator.preferences = {
    amount: price,
    currency: currency
  }
  shipping_method.calculator.save!
  shipping_method.save!
end

