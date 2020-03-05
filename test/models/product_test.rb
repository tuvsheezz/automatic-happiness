# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @user = User.create! email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    @product = Product.create title: Faker::Alphanumeric.alphanumeric(number: 10), price: Faker::Number.decimal, published: Faker::Boolean.boolean, user: @user
  end

  test 'should have a positive price' do
    product = @product
    product.price = -1
    assert_not product.valid?
  end
end
