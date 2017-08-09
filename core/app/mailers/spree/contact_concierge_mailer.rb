module Spree
  class ContactConciergeMailer < BaseMailer
    def notify_email(params)
      @customer = params["email"]
      @message = params["message"]
      subject = "Customer Inquiry"
      mail(to: "accounts@airlugg.com", from: from_address, subject: subject)
    end
  end
end
