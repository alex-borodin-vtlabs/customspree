require 'spec_helper'

describe Spree::UnservicedZipcodeMailer, :type => :mailer do
  before { create(:store) }

  it "sends a notification email to the admin" do
    Spree::UnservicedZipcodeMailer.notify_email(email: 'some@email.com', zipcode: '92708').deliver_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.first.to).to eq(['accounts@airlugg.com'])
  end
end
