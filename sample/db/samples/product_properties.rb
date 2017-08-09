products =
  { 
    "Tumi Alpha 2" => 
    { 
      "Type" => "Luggage"
    },
    "Samsonite Winfield 2" =>
    {
      "Type" => "Luggage"
    },
    "Beats Headphones" =>
    {
      "Type" => "Electronics"
    },
    "Travel Pillow" =>
    {
      "Type" => "Travel Comfort"
    },
    "Razor" =>
    {
      "Type" => "Health & Beauty"
    },
    "Ruby on Rails Tote" => 
    {
      "Type" => "Travel Comfort"
    },
    "Ruby on Rails Tote" =>
    {
      "Type" => "Travel Comfort"
    }
  }

products.each do |name, properties|
  product = Spree::Product.find_by_name(name)
  properties.each do |prop_name, prop_value|
    product.set_property(prop_name, prop_value)
  end
end
