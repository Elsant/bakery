# frozen_string_literal: true

require 'thor'
require 'ox'

Dir[File.join(__dir__, '..', 'lib', '*.rb')].sort.each { |file| require file }
Dir[File.join(__dir__, '..', 'lib', 'services', '*.rb')].sort.each { |file| require file }

# starts main app
class Backery < Thor
  desc 'calc_bunches', 'Calculates bunches and cost on given order'
  def calc_bunches
    # get seed data
    storage = Ox.parse_obj(File.read('data/storage.xml'))

    # build order
    raw_items = File.read('data/input.txt').split("\n")
    order = Order.build_from(raw_items, storage)

    # calculate bunches and cost
    OrderCalculator.new(order).call

    # print result
    OrderReporter.new(order).call
  end
end

Backery.start ARGV