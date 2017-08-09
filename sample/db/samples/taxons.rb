Spree::Sample.load_sample("taxonomies")
Spree::Sample.load_sample("products")

categories = Spree::Taxonomy.find_by_name!("Categories")

products = { 
  :tumi_alpha2 => "Tumi Alpha 2",
  :samsonite_winfield2 => "Samsonite Winfield 2",
  :beats_headphones => "Beats Headphones",
  :travel_pillow => "Travel Pillow",
  :razor => "Razor",
  :ror_tote => "Ruby on Rails Tote",
  :ror_bag => "Ruby on Rails Bag"
}


products.each do |key, name|
  products[key] = Spree::Product.find_by_name!(name)
end

taxons = [
  {
    :name => "Categories",
    :taxonomy => categories,
    :position => 0
  },
  {
    :name => "Luggage",
    :taxonomy => categories,
    :parent => "Categories",
    :position => 1,
    :products => [
      products[:tumi_alpha2],
      products[:samsonite_winfield2]
    ]
  },
  {
    :name => "Electronics",
    :taxonomy => categories,
    :parent => "Categories",
    :position => 2,
    :products => [
      products[:beats_headphones]
    ]
  },
  {
    :name => "Travel Comfort",
    :taxonomy => categories,
    :parent => "Categories",
    :position => 3,
    :products => [
      products[:travel_pillow],
      products[:ror_tote],
      products[:ror_bag]
    ]
  },
  {
    :name => "Health & Beauty",
    :taxonomy => categories,
    :parent => "Categories",
    :position => 4,
    :products => [
      products[:razor]
    ]
  }
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Spree::Taxon.where(name: taxon_attrs[:parent]).first
    Spree::Taxon.create!(taxon_attrs)
  end
end
