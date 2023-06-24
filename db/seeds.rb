# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# seeds.rb
# para limpiar todo de nuevo 
# seeds.rb
# seeds.rb
# para limpiar todo de nuevo 
ActiveRecord::Base.transaction do
  ActiveRecord::Base.connection.disable_referential_integrity do
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all
    Follow.destroy_all
  end

  # Crear usuarios
  10.times do |n|
    User.create!(
      email: "user#{n + 1}@example.com",
      encrypted_password: BCrypt::Password.create("password")
    )
  end

  # Crear posts
  User.all.each do |user|
    10.times do |n|
      user.posts.create!(
        content: "Post #{n + 1} by User #{user.id}"
      )
    end
  end





end







#   # Crear comentarios
#   Post.all.each do |post|
#     10.times do |n|
#       user = User.all.sample
#       post.comments.create!(
#         content: "Comment #{n + 1} on Post #{post.id} by User #{user.id}",
#         user_id: user.id
#       )
#     end
#   end

#   # Crear follows
#   User.all.each do |user|
#     10.times do
#       following = User.where.not(id: user.id).sample
#       user.followings << following unless user.followings.include?(following)
#     end
#   end
# end
