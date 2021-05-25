class Api::V1::UsersLoyalty < ApplicationLoyalty

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?; @user.id == @record.id; end

  def create?; true; end

  def update?; show?; end

  def destroy?; show?; end
end
