Book.destroy_all

10.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author
  )
end
