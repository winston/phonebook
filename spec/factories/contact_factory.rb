FactoryGirl.define do
  factory :contact do
    sequence(:name) { |n| "contact name #{n}" }
    phone "61234567"
  end
end
