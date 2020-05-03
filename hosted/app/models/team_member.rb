class TeamMember < ApplicationRecord
  validates :public_schedule_slug, presence: true, uniqueness: true
  validates :public_schedule_availability_email_address, presence: true, uniqueness: true
end
