# frozen_string_literal: true

require 'faker'

users = []
10.times do
  user = User.create(handle: Faker::Name.name)
  users << user
  3.times do
    Post.create(user: user, body: Faker::Lorem.sentence)
  end
end

users.each do |follower|
  users.reject { |u| u.id == follower.id }.each do |followee|
    Follow.create(follower: follower, followee: followee)
  end
end
