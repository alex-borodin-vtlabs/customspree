require 'spec_helper'

describe Spree::ContactConciergeMailer, :type => :mailer do
  before { create(:store) }

  it "sends a notification email to the admin" do
    Spree::ContactConciergeMailer.notify_email(email: 'some@email.com', message: 'Some Message').deliver_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.first.to).to eq(['accounts@airlugg.com'])
  end
end
