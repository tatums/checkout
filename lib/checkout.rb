class Checkout
  attr_reader :steps, :current

  def initialize(*steps)
    @steps = Array.new
    steps.each{|s| add s }
  end

  def current
    @steps.reject{|s| s.completed == true}.min_by(&:sequence)
  end

  def complete_current
    current.complete
  end

  private

  def add(step)
    step.sequence = @steps.size
    @steps << step
  end

end


class CheckoutStep
  attr_reader :title, :url
  attr_accessor :sequence, :completed

  def complete
    self.completed = true
  end
end

class BillingStep < CheckoutStep
  def initialize
    @title = "Billing"
    @url = '/cart/billing'
    @completed = false
  end
end

class ShippingStep < CheckoutStep
  def initialize
    @title = "Shipping"
    @url = '/cart/shipping'
    @completed = false
  end
end

class ConfirmationStep < CheckoutStep
  def initialize
    @title = "Confirmation"
    @url = '/cart/confirmation'
    @completed = false
  end
end
