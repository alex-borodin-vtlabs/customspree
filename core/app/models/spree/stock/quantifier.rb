module Spree
  module Stock
    class Quantifier
      attr_reader :stock_items, :variant, :zipcode

      def initialize(variant, zipcode=nil)
        @variant = variant
        @zipcode = zipcode
        @stock_items = Spree::StockItem.joins(:stock_location).where(variant_id: @variant, Spree::StockLocation.table_name => { active: true })
      end

      def total_on_hand
        if variant.should_track_inventory?
          stock_items_at_stock_location.sum(:count_on_hand)
        else
          Float::INFINITY
        end
      end

      def backorderable?
        stock_items_at_stock_location.any?(&:backorderable)
      end

      def can_supply?(required = 1)
        total_on_hand >= required || backorderable?
      end

      private

      def stock_items_at_stock_location
        if zipcode
          stock_location = Spree::ServiceableZipcode.find_by_zipcode(zipcode).try(:stock_location)
          stock_items.where(stock_location: stock_location)
        else
          stock_items
        end
      end
    end
  end
end
