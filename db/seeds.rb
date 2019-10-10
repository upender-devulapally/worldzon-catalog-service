# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
Category.destroy_all

(1..3).to_a.each do |n|
  category = Category.create(name: Faker::Commerce.department,
                             description: Faker::Lorem.paragraph((3..10).to_a.sample))
  i = 1
  (5..10).to_a.sample.times do |_p|
    Product.create(category: category,
                   name: Faker::Commerce.product_name,
                   sku: "#{format('%03d', n)}#{format('%04d', i)}",
                   description: Faker::Lorem.paragraph((5..10).to_a.sample))
    i += 1
  end
end