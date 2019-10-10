# frozen_string_literal: true

# schema for categories(predefined by admin)
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
