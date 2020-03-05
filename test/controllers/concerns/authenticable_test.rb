class AuthenticableTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create! email: Faker::Internet.email, password_digest: BCrypt::Password.create(Faker::Alphanumeric.alphanumeric(number: 10))
    @authentication = MockController.new
  end

  test 'should get user from Authorization token' do
    @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
    assert_equal @user.id, @authentication.current_user.id
  end

  test 'should not get user from empty Authorization token' do
    @authentication.request.headers['Authorization'] = nil
    assert_nil @authentication.current_user
  end
end


class MockController
  include Authenticable
  attr_accessor :request
  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end
