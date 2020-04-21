# frozen_string_literal: true

require_relative '../../lib/services/order_calculator'

RSpec.describe OrderCalculator do
  let(:order) { Order.new }
  subject { described_class.new(order) }

  it { is_expected.to respond_to :order }
end