FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    photo { 'default_photo.jpg' }
    bio { 'This is a sample bio.' }
    posts_counter { 0 }
    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 10, author: user, created_at: Time.current - rand(1..30).days)
      end
    end
  end
end
