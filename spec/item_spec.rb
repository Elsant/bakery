# frozen_string_literal: true

require_relative '../lib/item'

RSpec.describe Item do
  let(:product) { Product.new(name: 'Croissant', code: 'CF') }

  context 'with valid arguments' do
    subject { Item.new(product: product, quantity: 2) }

    it { is_expected.to respond_to :product }
    it 'has product' do
      expect(subject.product).to eq product
    end

    it { is_expected.to respond_to :quantity }
    it 'has quantity' do
      expect(subject.quantity).to eq 2
    end

    it { is_expected.to respond_to :bunches }
    it 'bunches are array' do
      expect(subject.bunches).to be_an_instance_of(Hash)
    end
  end

  context 'with invalid arguments' do
    context 'fails without product' do
      subject { Item.new(quantity: 2) }
      it 'raises error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'fails without quantity' do
      subject { Item.new(product: product) }
      it 'raises error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end