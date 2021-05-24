# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  before_action :check_login, only: [:create]
  before_action :set_product, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]
  before_action :authorize!
  after_action :verify_authorized

  def aaaa
    actions = Rails.application.routes.routes.map do |route|
      { controller: route.defaults[:controller].gsub('api/v1/', ''), action: route.defaults[:action] } if route.defaults[:controller]&.include? 'api/v1'
    end.compact.uniq

    privileges = {}

    actions.each do |x|
      privileges["#{x[:controller]}/#{x[:action]}"] = loyalty(:"#{x[controller]}").create?
    end

    render json: { Hi: loyalty(:products).index?, privileges: privileges }
  end
  
  def index
    @products = Product.all
    render json: ProductSerializer.new(@products).serializable_hash
  end

  def show
    options = { include: [:user] }
    render json: ProductSerializer.new(@product, options).serializable_hash
  end

  def create
    product = current_user.products.build(product_params)
    if product.save
      render json: ProductSerializer.new(product).serializable_hash, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serializable_hash, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def check_owner
    head :forbidden unless @product.user_id == current_user&.id
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
