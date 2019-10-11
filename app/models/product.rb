# frozen_string_literal: true

# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category

  # ==> Callbacks
  after_commit :perform_create_webhook, on: :create

  # ==> Public Methods  ----------------------------------------------------
  def perform_create_webhook
    Products::CreateWorker.perform_async(id)
  end
end
