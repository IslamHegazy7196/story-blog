# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
require 'faker'
# db/seeds.rb

50.times do |n|
  User.create!(username: "user#{n + 1}")
end

# Generate posts
50_000.times do
  user = User.all.sample
  user.posts.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
end

# Generate reviews for 20,000 random posts
Post.limit(20_000).each do |post|
  4.times do
    post.reviews.create!(rating: rand(1..5), comment: Faker::Lorem.sentence, user: User.all.sample)
  end
end
