FactoryBot.define do
  factory :team_member do
    public_schedule_slug { SecureRandom.uuid }
    public_schedule_availability_email_address { "#{SecureRandom.uuid}@example.com" }
  end
end
