Spree::Sample.load_sample("products")
Spree::Sample.load_sample("variants")

products = {}
products[:ror_tote] = Spree::Product.find_by_name!("Ruby on Rails Tote")
products[:ror_bag] = Spree::Product.find_by_name!("Ruby on Rails Bag")
products[:tumi_alpha2] = Spree::Product.find_by_name!("Tumi Alpha 2")
products[:samsonite_winfield2] = Spree::Product.find_by_name!("Samsonite Winfield 2")
products[:beats_headphones] = Spree::Product.find_by_name!("Beats Headphones")
products[:travel_pillow] = Spree::Product.find_by_name!("Travel Pillow")
products[:razor] = Spree::Product.find_by_name!("Razor")


def image(name, type="jpeg")
  images_path = Pathname.new(File.dirname(__FILE__)) + "images"
  path = images_path + "#{name}.#{type}"
  return false if !File.exist?(path)
  File.open(path)
end

images = {
  products[:ror_tote].master => [
    {
      :attachment => image("ror_tote")
    },
    {
      :attachment => image("ror_tote_back") 
    }
  ],
  products[:ror_bag].master => [
    {
      :attachment => image("ror_bag")
    }
  ],
  products[:tumi_alpha2].master => [
    {
      :attachment => image("tumi_alpha2", "jpg")
    }
  ],
  products[:samsonite_winfield2].master => [
    {
      :attachment => image("samsonite_winfield2", "jpg")
    }
  ],
  products[:beats_headphones].master => [
    {
      :attachment => image("beats_headphones")
    }
  ],
  products[:travel_pillow].master => [
    {
      :attachment => image("travel_pillow")
    }
  ],
  products[:razor].master => [
    {
      :attachment => image("razor", "jpg")
    }
  ]
}

images.each do |variant, attachments|
  puts "Loading images for #{variant.product.name}"
  attachments.each do |attachment|
    variant.images.create!(attachment)
  end
end

