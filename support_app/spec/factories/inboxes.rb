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

    trait :with_redirect_urls do
      redirect_on_completion { true }
      redirect_on_success_url { "https://example.com/success" }
      redirect_on_failure_url { "https://example.com/failure" }
    end
  end
end
