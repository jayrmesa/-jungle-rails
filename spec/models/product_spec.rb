require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    # validation tests/examples here

    context 'creating of new product with a new category' do
      before(:each) do
        @category = Category.new(name: 'Rose')
        @category.save!

        @product = @category.products.new(
          name: 'Aloha',
          price: '42.00',
          quantity: 3
        )
      end

      it 'is not valid when there is no name' do
        @product[:name] = nil
        @product.save
  
        expect(@product.errors.full_messages).not_to be_empty
      end
  
      it 'is not valid when there is no price' do
        @product[:price_cents] = nil
        @product.save
  
        expect(@product.errors.full_messages).not_to be_empty
      end
  
      it 'is not valid when there is no quantity' do
        @product[:quantity] = nil
        @product.save
  
        expect(@product.errors.full_messages).not_to be_empty
      end

      after(:each) do
        @product.destroy unless @product.nil?
        @category.destroy unless @category.nil?
      end
    end

    context 'creation of new product without a category' do
      it 'is not valid' do
        @new_product = Product.new(
          name: 'Aloha',
          price: '42.00',
          quantity: 3
        )
        @new_product.save

        expect(@new_product.errors.full_messages).not_to be_empty
      end
    end
  end
end