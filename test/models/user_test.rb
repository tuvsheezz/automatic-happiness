# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create! email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    @product = Product.create title: Faker::Alphanumeric.alphanumeric(number: 10), price: Faker::Number.decimal, published: Faker::Boolean.boolean, user: @user
  end

  test 'user with a valid email should be valid' do
    user = User.new email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    assert user.valid?
  end

  test 'user with invalid email should be invalid' do
    user = User.new email: Faker::Alphanumeric.alphanumeric(number: 10), password_digest: nil
    assert_not user.valid?
  end

  test 'user with taken email should be invalid' do
    other_user = @user
    user = User.new email: other_user.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)

    assert_not user.valid?
  end

  test 'destroy user should destroy linked product' do
    assert_difference('Product.count', -1) do
      @user.destroy
    end
  end
end
