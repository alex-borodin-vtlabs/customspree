module Spree
  class ShipmentHandler
    class << self
      def factory(shipment)
        # Do we have a specialized shipping-method-specific handler? e.g:
        # Given shipment.shipping_method = Spree::ShippingMethod::DigitalDownload
        # do we have Spree::ShipmentHandler::DigitalDownload?
        if sm_handler = "Spree::ShipmentHandler::#{shipment.shipping_method.name.split('::').last}".constantize rescue false
          sm_handler.new(shipment)
        else
          new(shipment)
        end
      end
    end

    def initialize(shipment)
      @shipment = shipment
    end

    def perform
      @shipment.inventory_units.each &:ship!
      @shipment.process_order_payments if Spree::Config[:auto_capture_on_dispatch]
      send_shipped_email
      queue_return_reminder_email
      @shipment.touch :shipped_at
      update_order_shipment_state
    end

    private
      def send_shipped_email
        ShipmentMailer.shipped_email(@shipment.id).deliver_later
      end

      def queue_return_reminder_email
        # only works if a queueing backend is setup
        OrderMailer.rental_return_reminder_email(@shipment.order.id).deliver_later(wait_until: @shipment.order.rental_end_date - 1.day)
      rescue NotImplementedError
        # only for testing purposes
        OrderMailer.rental_return_reminder_email(@shipment.order.id).deliver_later if Rails.env.development?
      end

      def update_order_shipment_state
        order = @shipment.order

        new_state = OrderUpdater.new(order).update_shipment_state
        order.update_columns(
                             shipment_state: new_state,
                             updated_at: Time.now,
                             )
      end
  end
end
