# frozen_string_literal: true

# app/models/category.rb
class Category < ApplicationRecord
  has_many :products, dependent: :nullify
end
