# frozen_string_literal: true

require_relative '../lib/product'

RSpec.describe Product do
  context 'with valid arguments' do
    subject { Product.new(name: 'Croissant', code: 'CF') }

    it { is_expected.to respond_to :name }
    it 'has name' do
      expect(subject.name).to eq 'Croissant'
    end

    it { is_expected.to respond_to :code }
    it 'has code' do
      expect(subject.code).to eq 'CF'
    end

    it { is_expected.to respond_to :packs }
    it 'packs are array' do
      expect(subject.packs).to be_an_instance_of(Array)
    end
  end

  context 'with invalid arguments' do
    context 'fails without name' do
      subject { Product.new(code: 'CF') }
      it 'raises error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'without code' do
      subject { Product.new(name: 'Croissant') }
      it 'fails raises error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  context 'finds pack by value' do
    let(:pack1) { Pack.new(quantity: 5, price: 9.95) }
    let(:pack2) { Pack.new(quantity: 3, price: 5.95) }
    let(:product) { Product.new(name: 'Croissant', code: 'CF') }

    before do
      product.packs << pack1
      product.packs << pack2
    end

    it 'finds pack by quantity' do
      expect(product.find_pack_by_quantity(5)).to eq pack1
    end

    it 'calculates cost for bunches' do
      bunches = { 5 => 2, 3 => 1 }
      expect(product.packs_cost(bunches)).to be_within(0.001).of(25.85)
    end
  end
end