# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
email: 'admin@admin',
password: 'password'
)

Post.create!(
  user_id: 1,
  title: "最初の投稿",
  body: "これは最初の投稿です。"
)

Post.create!(
  user_id: 1,
  title: "2番目の投稿",
  body: "これは2番目の投稿です。"
)

puts '初期データを追加しました。'