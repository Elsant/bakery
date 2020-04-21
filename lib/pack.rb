# frozen_string_literal: true

# Available packs
class Pack
  attr_reader :quantity, :price_in_cents

  def initialize(quantity:, price: 0)
    @quantity = quantity
    @price_in_cents = (price * 100).round
  end

  def price
    price_in_cents / 100.0
  end
end