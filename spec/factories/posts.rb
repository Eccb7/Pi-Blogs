FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
    # Add any other necessary attributes
  end
end
