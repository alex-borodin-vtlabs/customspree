module Spree
  module Admin
    module ShipmentsHelper
      def valid_states(shipment)
        options = Spree::Order::SHIPMENT_STATES.map do |state| 
          unless default_shipment_states.include?(state)
            [Spree.t("shipment_states.#{state}"), state]
          end
        end.compact
        options_for_select(options, shipment.state)
      end

      private

      def default_shipment_states
        %w(backorder canceled partial pending ready)
      end
    end
  end
end