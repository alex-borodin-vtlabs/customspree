module Spree
  module Api
    class ContactConciergesController < Spree::Api::BaseController
      def create
        ContactConciergeMailer.notify_email(contact_concierge_params).deliver_later
        render nothing: true
      end

      private

      def contact_concierge_params
        params.permit(:email, :message)
      end
    end
  end
end