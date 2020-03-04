require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create! email: Faker::Internet.email, password_digest: Faker::Alphanumeric.alphanumeric(number: 10)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end
end
