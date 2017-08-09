# Spree::Sample.load_sample("option_values")
Spree::Sample.load_sample("products")

tumi_alpha2 = Spree::Product.find_by_name!("Tumi Alpha 2")
samsonite_winfield2 = Spree::Product.find_by_name!("Samsonite Winfield 2")
beats_headphones = Spree::Product.find_by_name!("Beats Headphones")
travel_pillow = Spree::Product.find_by_name!("Travel Pillow")
razor = Spree::Product.find_by_name!("Razor")
ror_tote = Spree::Product.find_by_name!("Ruby on Rails Tote")
ror_bag = Spree::Product.find_by_name!("Ruby on Rails Bag")

masters = {
  tumi_alpha2 => {
    :sku => "ROR-001",
    :cost_price => 17,
    :is_rentable => true,
    :weight => 10.7,
    :height => 22,
    :width => 14,
    :depth => 9
  },
  samsonite_winfield2 => {
    :sku => "ROR-002",
    :cost_price => 17,
    :is_rentable => true,
    :weight => 10.7,
    :height => 22,
    :width => 14,
    :depth => 9
  },
  beats_headphones => {
    :sku => "ROR-003",
    :cost_price => 21,
    :is_rentable => true
  },
  travel_pillow => {
    :sku => "ROR-004",
    :cost_price => 17,
    :is_rentable => false
  },
  razor => {
    :sku => "ROR-005",
    :cost_price => 11,
    :is_rentable => false
  },
  ror_tote => {
    :sku => "ROR-006",
    :cost_price => 17,
    :is_rentable => false
  },
  ror_bag => {
    :sku => "ROR-007",
    :cost_price => 15,
    :is_rentable => false
  }
}

masters.each do |product, variant_attrs|
  product.master.update_attributes!(variant_attrs)
end
