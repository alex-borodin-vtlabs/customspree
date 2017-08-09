require 'spec_helper'

describe Spree::Order, :type => :model do
  let(:order) { Spree::Order.new }

  context 'validation' do
    context "when @use_billing is populated" do
      before do
        order.bill_address = stub_model(Spree::Address)
        order.ship_address = nil
      end

      context "with true" do
        before { order.use_billing = true }

        it "clones the bill address to the ship address" do
          order.valid?
          expect(order.ship_address).to eq(order.bill_address)
        end
      end

      context "with 'true'" do
        before { order.use_billing = 'true' }

        it "clones the bill address to the shipping" do
          order.valid?
          expect(order.ship_address).to eq(order.bill_address)
        end
      end

      context "with '1'" do
        before { order.use_billing = '1' }

        it "clones the bill address to the shipping" do
          order.valid?
          expect(order.ship_address).to eq(order.bill_address)
        end
      end

      context "with something other than a 'truthful' value" do
        before { order.use_billing = '0' }

        it "does not clone the bill address to the shipping" do
          order.valid?
          expect(order.ship_address).to be_nil
        end
      end
    end

    context "when @ship_address is populated" do
      before do
        order.ship_address = stub_model(Spree::Address)
        order.bill_address = nil
      end

      context "with true" do
        before { order.use_shipping = true }

        it "clones the ship address to the bill address" do
          order.valid?
          expect(order.bill_address).to eq(order.ship_address)
        end
      end

      context "with 'true'" do
        before { order.use_shipping = 'true' }

        it "clones the ship address to the billing" do
          order.valid?
          expect(order.bill_address).to eq(order.ship_address)
        end
      end

      context "with '1'" do
        before { order.use_shipping = '1' }

        it "clones the ship address to the billing" do
          order.valid?
          expect(order.bill_address).to eq(order.ship_address)
        end
      end

      context "with something other than a 'truthful' value" do
        before { order.use_shipping = '0' }

        it "does not clone the ship address to the billing" do
          order.valid?
          expect(order.bill_address).to be_nil
        end
      end
    end
  end
end