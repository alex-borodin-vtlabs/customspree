module Spree
  module ProductHelper
    def display_price_with_transaction_type(product_or_variant)
      price_display = display_price(product_or_variant)
      product_or_variant.is_rentable ? "Rental: #{price_display} / day" : "Purchase: #{price_display}"
    end
  end
end