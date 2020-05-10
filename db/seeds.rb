require 'faker'

NUM_USERS = 10_000

puts "Creating users database (with #{NUM_USERS} users)"

NUM_USERS.times do
  print '.'

  ActiveRecord::Base.transaction do
    User.create \
      name: Faker::Name.name,
      email: Faker::Internet.email
  end
end

puts 'Done.'
