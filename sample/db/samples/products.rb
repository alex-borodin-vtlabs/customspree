Spree::Sample.load_sample("tax_categories")
Spree::Sample.load_sample("shipping_categories")

tax_category = Spree::TaxCategory.find_by_name!("Default")
shipping_category = Spree::ShippingCategory.find_by_name!("Default")

default_attrs = {
  :description => Faker::Lorem.paragraph,
  :available_on => Time.zone.now
}

products = [
  {
    :name => "Tumi Alpha 2",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 10.99,
    :description => "TUMI elevates your travel experience with Alpha 2, the pinnacle of our design innovation, engineering, functionality and performance. Alpha 2 embodies TUMI’s commitment to making the best better; it incorporates over 30 design improvements and more than 14 patented and trademarked TUMI components. The result is a collection of cases that are lighter and stronger while offering increased packing capacity, sleeker profiles, smarter functionality and easier maneuverability."
  },
  {
    :name => "Samsonite Winfield 2",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 15.99,
    :description => "The Winfield 2 20 is a fashionable, state of the art hardside spinner suitcase designed to make travel effortless. The Winfield 2 hard shell suitcase is crafted with 100% polycarbonate material for maximum durability and versatility. Deceptively lightweight luggage equipped with a retractable handle and 4 multi-directional wheels, so you can whip around from airports to crowded city streets with ease."
  },
  {
    :name => "Beats Headphones",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 9.99,
    :description => "Break through the limitations of wired listening. Unplug your Solo2 Wireless, pair with your Bluetooth® device and move freely for up to 30 feet of wireless listening. Take hands-free calls with the built in mic, and use the on-ear controls to adjust your listening experience without reaching for your device. Stay unplugged all day thanks to the 12-hour rechargeable battery. The illuminated LED fuel gauge on the headphone lets you know when it’s time to recharge."
  },
  {
    :name => "Travel Pillow",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 10.99,
    :description => "The TravelMate(R) Memory Foam Travel Neck Pillow is specifically designed in such a way that it has just the right softness to provide the most comfortable support for your neck. The thermo-sensitive memory foam will mold to your body's natural contours for a custom fit. It helps relieve the tension in your neck and shoulders due to prolonged sitting. Use it on a plane, car, or anywhere you need the extra support for your neck and shoulders. You will definitely like the soft and comfortable feel of this pillow. The cover is made of high-quality, machine-washable velour cover. Built-in elastic strap makes it easy to attach to a carry-on luggage without taking up extra space. Simple put, you get a high-end product at a fraction of the cost of what you pay at upscale specialty stores."
  },
  {
    :name => "Razor",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 8.99,
    :description => "Gillette Fusion razor blades feature advanced 5-blade technology • Gillette Fusion razor blades are spaced closer together than Mach3 to help reduce pressure for a close, comfortable shave"
  },
  {
    :name => "Ruby on Rails Tote",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 15.99,
    :description => "A lovely RoR tote bag for all your toting needs."
  },
  {
    :name => "Ruby on Rails Bag",
    :tax_category => tax_category,
    :shipping_category => shipping_category,
    :price => 22.99,
    :description => "A lovely RoR bag for all your bagging needs."
  }
]

products.each do |product_attrs|
  Spree::Config[:currency] = "USD"

  default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
  product = Spree::Product.create!(default_attrs.merge(product_attrs))
  product.shipping_category = default_shipping_category
  product.save!
end
