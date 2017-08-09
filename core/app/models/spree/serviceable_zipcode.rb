module Spree
  class ServiceableZipcode < Spree::Base
    belongs_to :stock_location, class_name: 'Spree::StockLocation'

    validates_presence_of :stock_location_id, :zipcode
    validates_uniqueness_of :zipcode
  end
end