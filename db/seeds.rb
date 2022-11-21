# frozen_string_literal: true

require 'faker'

users = []
100.times do
  user = User.create(handle: Faker::Name.name)
  users << user
  50.times do
    Post.create(user: user, body: Faker::Lorem.sentence)
  end
end

first_user = User.first
users.each do |follower|
  Follow.create(follower: follower, followee: first_user)
end
