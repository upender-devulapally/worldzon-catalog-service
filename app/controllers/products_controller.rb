# frozen_string_literal: true

# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    products = Product.all.limit(2)
    render json: { products: products }, status: :ok
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: product.errors.full_message, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :ok
  end

  private

  def product_params
    params.permit(:category_id, :name, :sku, :description)
  end
end
