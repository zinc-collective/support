require "rails_helper"

RSpec.describe "Guest messages inbox", type: :system do
  before do
    @guest = FactoryBot.build(:guest)
    @mailcatcher = Coruro.new(adapter: :mailcatcher)
  end

  context "with a redirect" do
    scenario "Sending a message successfully" do
      inbox = FactoryBot.create(:inbox, :with_support_staff, :with_redirect_urls)
      visit inbox_path(inbox)
      message_content = "Can you send me the pricing for your services?"

      within "#new_inbound_message" do
        find('*[name="inbound_message[sender_name]"]').fill_in(with: @guest.name)
        find('*[name="inbound_message[sender_email]"]').fill_in(with: @guest.email)
        find('*[name="inbound_message[raw_body]"]').fill_in(with: message_content)
        find('*[name="commit"]').click
      end

      expect(page.current_url).to eql inbox.redirect_on_success_url
    end

    scenario "Failing to send a message" do
      inbox = FactoryBot.create(:inbox, :with_support_staff, :with_redirect_urls)
      visit inbox_path(inbox)

      within "#new_inbound_message" do
        find('*[name="commit"]').click
      end

      expect(page.current_url).to eql inbox.redirect_on_failure_url
    end
  end
  scenario "Sending a message to an inbox with a confirmation message" do
    inbox = FactoryBot.create(:inbox, :with_support_staff)

    visit inbox_path(inbox)
    message_content = "Can you send me the pricing for your services?"

    within "#new_inbound_message" do
      find('*[name="inbound_message[sender_name]"]').fill_in(with: @guest.name)
      find('*[name="inbound_message[sender_email]"]').fill_in(with: @guest.email)
      find('*[name="inbound_message[raw_body]"]').fill_in(with: message_content)
      find('*[name="commit"]').click
    end

    message = inbox.inbound_messages.where(sender_name: @guest.name,
                                           sender_email: @guest.email,
                                           status: :received).last

    aggregate_failures do
      expect(page).to have_text(inbox.confirmation_message)
      expect(message).to be_present
      expect(message.raw_body).to eql(message_content)
      expect(5.seconds.ago..Time.now).to include(message.received_at)
      expect(message.receipts
        .delivered
        .about(:"message.delivered")
        .to(@guest.email)).not_to be_empty

      guest_receipt_email = @mailcatcher.where(to: /#{@guest.email}/).first
      expect(guest_receipt_email).to have_subject("Your message to #{inbox.name} has been received.")
      expect(guest_receipt_email).to have_body_text(/Hello #{message.sender_name},/)
    end

    inbox.support_staff.each do |staff|
      aggregate_failures do
        staff_receipt_email = @mailcatcher.where(to: /#{staff.email_for(inbox)}/).first
        expect(staff_receipt_email).to have_subject("Message to #{inbox.name} from #{@guest.name}.")
        expect(staff_receipt_email).to have_body_text(message_content)

        expect(message.receipts
          .delivered
          .about(:"inbox.message.received")
          .to(staff.email_for(inbox))).not_to be_empty

        expect(staff.received_receipts
          .delivered
          .about(:"inbox.message.received")
          .regarding(message)).to be_present
      end
    end
  end
end
