# frozen_string_literal: true

require_relative '../../lib/services/order_reporter'

RSpec.describe OrderReporter do
  let(:order) { Order.new }
  let(:pack1) { Pack.new(quantity: 5, price: 9.95) }
  let(:pack2) { Pack.new(quantity: 3, price: 5.95) }
  let(:product) { Product.new(name: 'Croissant', code: 'CF') }
  let(:item) { Item.new(product: product, quantity: 13) }
  subject { described_class.new(order) }

  before do
    order.items << item
    product.packs << pack1
    product.packs << pack2
    item.bunches = { 5 => 2, 3 => 1 }
    item.total_price = 25.85
  end

  it 'prints report' do
    report = "13 CF $25.85\n\t2 x 5 $9.95\n\t1 x 3 $5.95\n"
    expect(subject.build_report).to eq report
  end

  it { is_expected.to respond_to :order }
end