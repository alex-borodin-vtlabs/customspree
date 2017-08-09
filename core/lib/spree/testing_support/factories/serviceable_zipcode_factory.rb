FactoryGirl.define do
  factory :serviceable_zipcode, class: Spree::ServiceableZipcode do
    zipcode '90025'
    stock_location { |zipcode| Spree::StockLocation.first || create(:stock_location) }
  end
end