class Api::V1::TokensLoyalty < ApplicationLoyalty

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?; true; end
end
