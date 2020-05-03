require 'rails_helper'

RSpec.describe TeamMember, type: :model do
  subject(:team_member) { FactoryBot.build(:team_member) }
  describe "#public_schedule_availability_email_address" do
    it { is_expected.to validate_uniqueness_of(:public_schedule_availability_email_address) }
    it { is_expected.to validate_presence_of(:public_schedule_availability_email_address) }
  end

  describe "#public_schedule_slug" do
    it { is_expected.to validate_uniqueness_of(:public_schedule_slug) }
    it { is_expected.to validate_presence_of(:public_schedule_slug) }
  end

end
