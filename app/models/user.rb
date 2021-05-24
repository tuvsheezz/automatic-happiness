# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true

  has_many :products, dependent: :destroy

  enum role: { guest: 0, guest2: 1, admin: 2 }
end
