# frozen_string_literal: true

require 'forwardable'

# Determines items for order with quantity and products
class Item
  attr_reader :product, :quantity
  attr_accessor :bunches, :total_price

  extend Forwardable

  def_delegators :product, :pack_values, :packs, :packs_cost, :code, :find_pack_by_quantity

  def initialize(product:, quantity:)
    @product = product
    @quantity = quantity
    @bunches = Hash.new(0)
    @total_price = 0
  end
end