class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvc, :card_expires_month, :card_expires_year
  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map do |name, index|
      ["#{index + 1} - #{name}", index + 1]
    end
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def process_payment
    # Create customer without card first
    customer = Stripe::Customer.create(
      email: email
    )

    # Attach token (legacy card token) to the customer
    Stripe::Customer.create_source(
      customer.id,
      { source: token } # token from Stripe Elements or frontend
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: 1000, # Amount in cents
      description: 'Payment premium subscription',
      currency: 'usd'
    )
  end
end