FactoryBot.define do
  factory :inbound_message do
    inbox

    trait :from_guest_sender do
      transient do
        guest { build(:guest) }
      end
      sender_name { guest.name }
      sender_email { guest.email }
    end
  end
end
