class Api::V1::ProductsLoyalty < ApplicationLoyalty
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?; true; end

  def show?; !@user.nil?; end

  def create?
    @user.admin?
  end

  def update?; create?; end

  def destroy?; create?; end

  def aaaa?; true; end
end
