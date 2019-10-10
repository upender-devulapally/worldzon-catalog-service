# frozen_string_literal: true

# primary schema for products
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :category, foreign_key: true, type: :uuid, null: false
      t.string :name, null: false, index: true
      t.text :description
      t.string :sku

      t.timestamps
    end
  end
end
