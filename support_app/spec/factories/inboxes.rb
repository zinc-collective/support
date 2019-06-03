FactoryBot.define do
  factory :inbox do
    name { FFaker::Company.name }
    confirmation_message { "We'll get back to you!" }

    trait :with_support_staff do
      transient do
        staff_count { 1 }
      end

      after(:create) do |inbox, evaluator|
        create_list(:inbox_permission, evaluator.staff_count, inbox: inbox)
      end
    end
  end
end
