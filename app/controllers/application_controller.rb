# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable
  include Banken

  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    loyalty_name = exception.loyalty.class.to_s.underscore

    render json: { error: "not authorized" }
  end
end
