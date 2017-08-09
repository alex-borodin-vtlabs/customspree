module Spree
  class UnservicedZipcodeMailer < BaseMailer
    def notify_email(params)
      @customer = params["email"]
      @zipcode = params["zipcode"]
      subject = "Unserviced Zipcode"
      mail(to: "accounts@airlugg.com", from: from_address, subject: subject)
    end
  end
end
