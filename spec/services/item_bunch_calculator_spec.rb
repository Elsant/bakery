# frozen_string_literal: true

require_relative '../../lib/services/item_bunch_calculator'

RSpec.describe ItemBunchCalculator do
  context 'valid quantity' do
    let(:pack1) { Pack.new(quantity: 5, price: 9.95) }
    let(:pack2) { Pack.new(quantity: 3, price: 5.95) }
    let(:product) { Product.new(name: 'Croissant', code: 'CF') }
    let(:item) { Item.new(product: product, quantity: 13) }
    subject { described_class.new(item) }

    before do
      product.packs << pack1
      product.packs << pack2
    end

    it 'calculates bunches' do
      subject.call
      expect(subject.item.bunches).to eq(5 => 2, 3 => 1)
    end

    it { is_expected.to respond_to :item }
  end

  context 'invalid quantity' do
    let(:pack1) { Pack.new(quantity: 5, price: 9.95) }
    let(:pack2) { Pack.new(quantity: 3, price: 5.95) }
    let(:product) { Product.new(name: 'Croissant', code: 'CF') }
    let(:item) { Item.new(product: product, quantity: 2) }
    subject { described_class.new(item) }

    before do
      product.packs << pack1
      product.packs << pack2
    end

    it 'does not calculates bunches for quantity 2' do
      subject.call
      expect(subject.item.bunches).to be_empty
    end

    it { is_expected.to respond_to :item }
  end
end