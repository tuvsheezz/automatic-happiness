class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email
  attributes :password_digest
  attributes self.products
end
