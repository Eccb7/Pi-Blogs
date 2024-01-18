FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    photo { 'default_photo.jpg' }
    bio { 'This is a sample bio.' }
    posts_counter { 0 }
    # Add any other necessary attributes
  end
end
