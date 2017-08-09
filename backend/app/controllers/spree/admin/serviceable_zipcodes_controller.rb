module Spree
  module Admin
    class ServiceableZipcodesController < ResourceController

      def collection
        super.order(:zipcode)
      end
    end
  end
end
