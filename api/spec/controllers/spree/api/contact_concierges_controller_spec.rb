require 'spec_helper'

module Spree
  describe Api::ContactConciergesController, type: :controller do
    describe "#create" do
      before do
        create(:store)
        Spree::Api::Config[:requires_authentication] = false
      end

      it "should invoke the mailer" do
       mail_message = double "Mail::Message"
       post_params = { email: 'some@email.com', message: 'Some Message' }
       expect(Spree::ContactConciergeMailer).to receive(:notify_email).with(post_params).and_return mail_message
       expect(mail_message).to receive :deliver_later
       post :create, post_params
      end
    end
  end
end