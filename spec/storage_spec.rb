# frozen_string_literal: true

require_relative '../lib/storage'

RSpec.describe Storage do
  it { is_expected.to respond_to :products }
  it 'products are array' do
    expect(subject.products).to be_an_instance_of(Array)
  end

  context 'search ability' do
    let(:product1) { Product.new(name: 'Croissant', code: 'CF') }
    let(:product2) { Product.new(name: 'Blueberry Muffin', code: 'MB11') }
    let(:code) { 'MB11' }

    before do
      subject.products << product1
      subject.products << product2
    end

    it 'finds products by code' do
      product = subject.find_product_by_code(code)
      expect(product).to eq product2
    end
  end
end