require 'spec_helper'

describe EcwidApi::Order do
  subject do
    EcwidApi::Order.new({
      "number" => 123,
      "billingPerson" => {
        "name" => "John Doe"
      },
      "shippingPerson" => shipping_person,
      "items" => [{
        "sku" => "112233"
      }]
    })
  end

  let(:shipping_person) { nil }

  its(:id) { should == 123 }

  describe "#billing_person" do
    its(:billing_person) { should be_a(EcwidApi::Person) }

    it "has the correct data" do
      subject.billing_person.name.should == "John Doe"
    end
  end

  describe "#shipping_person" do
    its(:shipping_person) { should be_a(EcwidApi::Person) }

    context "without a shipping person" do
      let(:shipping_person) { nil }
      its(:shipping_person) { should == subject.billing_person }
    end

    context "with a shipping person" do
      let(:shipping_person) { {"name" => "Jane Doe"} }
      it "has the correct data" do
        subject.shipping_person.name.should == "Jane Doe"
      end
    end
  end

  describe "#items" do
    it "has the correct number of items" do
      subject.items.size.should == 1
    end

    it "has the correct data" do
      subject.items.first.sku.should == "112233"
    end
  end
end