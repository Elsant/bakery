# frozen_string_literal: true

# Calculates bunches for item
class ItemBunchCalculator
  ImpossiblePackageError = Class.new(StandardError)

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def call
    calculate_result
    define_bulks(total_quantity, bunch_sizes)
    item.total_price = item.packs_cost(item.bunches)
  rescue ImpossiblePackageError
    nil
  end

  def calculate_result
    (1..total_quantity).each do |index|
      item.pack_values.each do |pack_value|
        next if pack_value > total_quantity

        resolve(index, pack_value)
      end
    end
    raise ImpossiblePackageError unless bunch_sizes[total_quantity]
  end

  def resolve(index, pack_value)
    positive_or_zero = index - pack_value >= 0
    raise ImpossiblePackageError if result[index - pack_value].nil?

    found = result[index - pack_value] + 1 < result[index]
    return unless positive_or_zero && found

    store_result(index, pack_value)
  end

  def store_result(index, pack_value)
    result[index] = result[index - pack_value] + 1
    bunch_sizes[index] = pack_value
  end

  def define_bulks(quantity, bunch_sizes)
    return if quantity.zero?

    define_bulks(quantity - bunch_sizes[quantity], bunch_sizes)
    item.bunches[bunch_sizes[quantity]] += 1
  end

  private

  def total_quantity
    item.quantity
  end

  def result
    @result ||= begin
      Array.new(total_quantity, Float::INFINITY).unshift(0)
    end
  end

  def bunch_sizes
    @bunch_sizes ||= Array.new(total_quantity + 1)
  end
end