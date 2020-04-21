# frozen_string_literal: true

# Stores all products in one place
class Storage
  attr_accessor :products

  def initialize
    @products = []
  end

  def find_product_by_code(code)
    products.select { |product| product.code == code }.first
  end
end