# frozen_string_literal: true

require_relative '../lib/pack'

RSpec.describe Pack do
  context 'with valid arguments' do
    subject { described_class.new(quantity: 3, price: 6.99) }

    it { is_expected.to respond_to :quantity }
    it 'has quantity' do
      expect(subject.quantity).to eq 3
    end

    it { is_expected.to respond_to :price_in_cents }
    it 'has price_in_cents' do
      expect(subject.price_in_cents).to eq 699
    end

    it { is_expected.to respond_to :price }
    it 'has price' do
      expect(subject.price).to be_within(0.001).of(6.99)
    end
  end

  context 'with invalid arguments' do
    it 'raises error without quantity' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end