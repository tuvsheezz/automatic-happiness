class Api::V1::ProductsLoyalty < ApplicationLoyalty
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?; true; end

  def create?
    @user.admin?
  end

  def aaaa?; true; end
end
