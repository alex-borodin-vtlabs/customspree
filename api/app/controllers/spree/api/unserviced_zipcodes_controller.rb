module Spree
  module Api
    class UnservicedZipcodesController < Spree::Api::BaseController
      def create
        UnservicedZipcodeMailer.notify_email(unserviced_zipcode_params).deliver_later
        render nothing: true
      end

      private

      def unserviced_zipcode_params
        params.permit(:zipcode, :email)
      end
    end
  end
end