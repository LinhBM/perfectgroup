class Payment < ApplicationRecord
  belongs_to :users

  def process_payment email, token
    customer = Stripe::Customer.create(
      email: email,
      source: token
    )
    Stripe::Charge.create(
      customer: customer.id,
      amount: self.amount.to_i,
      description: "Just buy",
      currency: "usd"
    )
  end
end
