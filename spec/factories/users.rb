FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email-#{n}@example.com" }
    name { 'User Name' }
  end
end
