require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Test spec')
    end
    it "Should be invalid without a name" do
      product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it "Should be invalid without a price" do
      product = Product.new(name: 'John Doe', price: nil, quantity: 10, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it "Should be invalid without a quantity" do
      product = Product.new(name: 'John Doe', price: 100, quantity: nil, category: @category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "Should be invalid without a category" do
      product = Product.new(name: 'John Doe', price: 100, quantity: 10, category: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
    it "should be valid with all fields saved" do
      product = Product.new(name: 'John Doe', price: 100, quantity: 10, category: @category)
      expect(product).to be_valid
      expect(product.save).to be true
    end
  end
end
