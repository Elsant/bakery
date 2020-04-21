# frozen_string_literal: true

# Determines products and stores packs for product
class Product
  attr_reader :code, :name
  attr_accessor :packs

  def initialize(code:, name:)
    @code = code
    @name = name
    @packs = []
  end

  def pack_values
    packs.map(&:quantity)
  end

  def find_pack_by_quantity(value)
    packs.select { |pack| pack.quantity == value }.first
  end

  def packs_cost(bunches)
    total_price = 0
    bunches.each do |bunch_size, quantity|
      pack = find_pack_by_quantity(bunch_size)
      total_price += pack.price_in_cents * quantity if pack
    end
    total_price / 100.0
  end
end