# frozen_string_literal: true

# calculates bunches and prices for order
class OrderCalculator
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    order.items.each do |item|
      ItemBunchCalculator.new(item).call
    end
  end
end