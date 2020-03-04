require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase
  test 'user with a valid email should be valid' do
    user = User.new email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    assert user.valid?
  end

  test 'user with invalid email should be invalid' do
    user = User.new email: Faker::Alphanumeric.alphanumeric(number: 10), password_digest: nil
    assert_not user.valid?
  end

  test 'user with taken email should be invalid' do
    other_user = User.new email: Faker::Alphanumeric.alphanumeric(number: 10), password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    user = User.new email: other_user.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
    assert_not user.valid?
  end
end
