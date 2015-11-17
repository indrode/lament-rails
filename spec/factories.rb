FactoryGirl.define do
  factory :category do
    title 'category'
    articles_count 1
  end

  factory :article do
    sequence(:number) { |n| n }
    sequence(:permalink) { |n| "permalink#{n}" }
    title 'Article Title'
    blurb 'This is a test article blurb.'
    markdown 'This is the main article copy.'
    sequence(:posted_at) { |n| (100 - n).days.ago }
    sequence(:created_at) { |n| (100 - n).days.ago }
    sequence(:updated_at) { |n| (100 - n).days.ago }
    enabled true
    category
  end

  factory :feature do
    key 'a_feature_key'
    enabled false
  end

  factory :setting do
    key 'a_setting_key'
    value '1'
  end
end
