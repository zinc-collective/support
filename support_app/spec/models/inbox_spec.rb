require "rails_helper"

RSpec.describe Inbox, type: :model do
  let(:inbox) { FactoryBot.create(:inbox) }
  describe "#process_inbound_message" do
    context "when the inbound message is invalid" do
      it "does not save the inbound message" do
        inbound_message = inbox.process_inbound_message({})
        expect(inbound_message).not_to be_persisted
      end

      it "does not create receipts" do
        expect { inbox.process_inbound_message({}) }.not_to(change { Receipt.count })
      end
    end
    context "when the inbound message is valid" do
      it "stores the message in the database" do
        inbound_message = inbox.process_inbound_message(raw_body: "A message", sender_email: "sender@example.com", sender_name: "sender")
        expect(inbound_message).to be_persisted
      end

      it "stores and delivers a receipt for the message creator" do
        inbound_message = inbox.process_inbound_message(raw_body: "A message", sender_email: "sender@example.com", sender_name: "sender")
        expect(inbound_message.receipts
          .delivered.to("sender@example.com")
          .about(:"message.delivered")).to be_present
      end

      it "stores and delivers a receipt to the staff for the inbox" do
        inbox = FactoryBot.create(:inbox, :with_support_staff)
        inbound_message = inbox.process_inbound_message(raw_body: "A message", sender_email: "sender@example.com", sender_name: "sender")
        inbox.support_staff.each do |staff|
          aggregate_failures do
            expect(inbound_message.receipts
              .delivered
              .about(:"inbox.message.received")
              .to(staff.email_for(@inbox))).not_to be_empty

            expect(staff.received_receipts
                    .delivered
                    .about(:"inbox.message.received")
                    .regarding(inbound_message)).to be_present
          end
        end
      end
    end
  end
end
