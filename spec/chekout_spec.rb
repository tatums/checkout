require 'spec_helper'

describe Checkout do

  before do
    @checkout = Checkout.new(ShippingStep.new, BillingStep.new, ConfirmationStep.new)
  end

  it "can be instantiated" do
    Checkout.new.should be_an_instance_of(Checkout)
  end

  it "have an array of steps" do
    @checkout.steps.should be_an_instance_of(Array)
  end

  it "have 3 steps" do
    @checkout.steps.size.should == 3
  end

  it "should return current step" do
    @checkout.current.should be_an_instance_of(ShippingStep)
  end

  it "should return the next step" do
    @checkout.next.should be_an_instance_of(BillingStep)
    @checkout.current.complete
    @checkout.next.should be_an_instance_of(ConfirmationStep)
    @checkout.current.complete
    @checkout.next.should be nil
  end

  it "should return nil when checking for the previous step" do
    @checkout.previous.should be nil
    @checkout.current.complete
    @checkout.previous.should be_an_instance_of(ShippingStep)
  end

  it "should be able to complete a step" do
    @checkout.current == be_an_instance_of(ShippingStep)
    @checkout.current.should respond_to :complete
    @checkout.current.complete
    @checkout.current.should be_an_instance_of(BillingStep)
  end

  it "current step should have a sequence number" do
    @checkout.current.should respond_to :sequence
  end

  it "current step should have a completed variable" do
    @checkout.current.should respond_to :completed
  end

end

describe ShippingStep do
  before do
    @shipping = ShippingStep.new
  end

  it "can be instantiated" do
    @shipping.should be_an_instance_of(ShippingStep)
  end

  it "should have a title" do
    @shipping.title.should == "Shipping"
  end

end
