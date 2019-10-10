# frozen_string_literal: true

# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
end
