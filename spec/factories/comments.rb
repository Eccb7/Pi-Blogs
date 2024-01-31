FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Comment Text #{n}" }
    user
    post
  end
end
