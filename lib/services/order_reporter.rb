# frozen_string_literal: true

# prints results
class OrderReporter
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    File.open('data/output.txt', 'w') { |file| file.write(build_report) }
  end

  def build_report
    report = ''
    order.items.each do |item|
      report += "#{item.quantity} #{item.code} $#{item.total_price}\n"
      if item.bunches.empty?
        report += "\tItem can not be packed with given packs\n"
      else
        item.bunches.each do |bunch_size, quantity|
          pack = item.find_pack_by_quantity(bunch_size)
          report += "\t#{quantity} x #{bunch_size} $#{pack.price}\n"
        end
      end
    end
    report
  end
end