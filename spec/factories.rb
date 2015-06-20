FactoryGirl.define do
  factory :category do
    title 'category'
    articles_count 1
  end

  factory :article do
    sequence(:number) { |n| n }
    title 'Article Title'
    blurb 'This is a test article blurb.'
    markdown 'This is the main article copy.'
    sequence(:posted_at) { |n| (100 - n).days.ago }
    sequence(:created_at) { |n| (100 - n).days.ago }
    sequence(:updated_at) { |n| (100 - n).days.ago }
    enabled true
    category
  end
end
