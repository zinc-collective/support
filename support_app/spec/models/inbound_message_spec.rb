require "rails_helper"

describe InboundMessage do
  it { is_expected.to validate_presence_of(:sender_email) }
  it { is_expected.to validate_presence_of(:sender_name) }
end
