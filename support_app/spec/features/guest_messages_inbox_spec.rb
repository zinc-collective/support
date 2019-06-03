require "rails_helper"

RSpec.describe "Guest messages inbox", :type => :system do
  before do
    driven_by(:rack_test)
    @inbox = FactoryBot.create(:inbox, :with_support_staff)
    @guest = FactoryBot.build(:guest)
  end

  it "Displays a confirmation message" do
    visit inbox_path(@inbox)
    message_content = "Can you send me the pricing for your services?"

    within '#new_inbound_message' do
      find('*[name="inbound_message[sender_name]"]').fill_in(with: @guest.name)
      find('*[name="inbound_message[sender_email]"]').fill_in(with: @guest.email)
      find('*[name="inbound_message[raw_body]"]').fill_in(with: message_content)
      find('*[name="commit"]').click
    end

    message = @inbox.inbound_messages.where(sender_name: @guest.name,
                                            sender_email: @guest.email,
                                            status: :received).last

    aggregate_failures do
      expect(message).to be_present

      expect(message.raw_body).to eql(message_content)
      expect(5.seconds.ago..Time.now).to include(message.received_at)
      expect(page).to have_text(@inbox.confirmation_message)
      expect(message.receipts
        .delivered
        .about(:"message.delivered")
        .to(@guest.email)
      ).not_to be_empty
    end

    @inbox.support_staff.each do |staff|
      expect(message.receipts
        .delivered
        .about(:"inbox.message.received")
        .to(staff.email_for(@inbox))).not_to be_empty

      expect(staff.received_receipts
              .delivered
              .about(:"inbox.message.received")
              .regarding(message)).to be_present
    end
  end
end