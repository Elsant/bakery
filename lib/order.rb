# frozen_string_literal: true

# Stores all item in one place
class Order
  attr_accessor :items

  def initialize
    @items = []
  end

  def self.build_from(raw_items, storage)
    new.tap do |order|
      raw_items.each do |item|
        regexp = /(?<quantity>\d+)\s+?(?<code>\w+.)/
        match_data = regexp.match(item)
        code = match_data[:code]
        quantity = match_data[:quantity].to_i
        if code && quantity
          product = storage.find_product_by_code(code)
          if product
            order.items.push(Item.new(product: product, quantity: quantity))
          else
            STDOUT.puts "Can not find product for #{item}."
          end
        else
          STDOUT.puts "Item: #{item} in not valid and will not be processed."
        end
      end
    end
  end
end