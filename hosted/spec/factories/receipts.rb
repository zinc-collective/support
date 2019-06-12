FactoryBot.define do
  factory :receipt do
    trait :message_delivered do
      topic { :'message.delivered' }
    end

    trait :inbox_message_received do
      topic { :'inbox.message.received' }
    end
  end
end
