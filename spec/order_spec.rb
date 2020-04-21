# frozen_string_literal: true

require_relative '../lib/order'

RSpec.describe Order do
  context 'class methods' do
    let(:storage) { Storage.new }
    let(:product1) { Product.new(name: 'Croissant', code: 'CF') }
    let(:product2) { Product.new(name: 'Blueberry Muffin', code: 'MB11') }
    let(:raw_items) { ['13 CF', '14 MB11'] }

    before do
      storage.products << product1
      storage.products << product2
    end

    it 'builds order with given raw_items and storage' do
      order = described_class.build_from(raw_items, storage)
      aggregate_failures do
        expect(order.items.length).to eq 2

        item1, item2 = *order.items
        expect(item1.product).to eq product1
        expect(item1.quantity).to eq 13
        expect(item2.product).to eq product2
        expect(item2.quantity).to eq 14
      end
    end
  end

  it { is_expected.to respond_to :items }
  it 'items are array' do
    expect(subject.items).to be_an_instance_of(Array)
  end
end