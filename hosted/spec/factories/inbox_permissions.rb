FactoryBot.define do
  factory :inbox_permission do
    association :person
    association :inbox
  end
end
