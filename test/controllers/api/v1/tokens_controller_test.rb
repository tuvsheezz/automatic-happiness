# frozen_string_literal: true

require 'test_helper'

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @password = Faker::Alphanumeric.alphanumeric(number: 10)
    @user = User.create!(
      email: Faker::Internet.email,
      password_digest: BCrypt::Password.create(@password)
    )
  end

  test 'should get JWT token' do
    post  api_v1_tokens_url,
          params: {
            user: {
              email: @user.email,
              password: @password
            }
          },
          as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test 'should not get JWT token' do
    post  api_v1_tokens_url,
          params: {
            user: {
              email: @user.email,
              password: @password[1..-1]
            }
          },
          as: :json
    assert_response :unauthorized
  end
end
