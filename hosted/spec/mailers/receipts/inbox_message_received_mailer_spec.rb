require "rails_helper"
module Receipts
  RSpec.describe InboxMessageReceivedMailer, type: :mailer do
    describe "notify" do
      let(:inbox) { FactoryBot.create(:inbox, :with_support_staff) }
      let(:message) { FactoryBot.create(:inbound_message, :from_guest_sender, inbox: inbox) }
      let(:receipt) do
        FactoryBot.create(:receipt, :inbox_message_received, receiptable: message,
                                                             via: :email, address: inbox.support_staff.first.email)
      end
      subject(:mail) { InboxMessageReceivedMailer.receipt_email(receipt) }

      it { is_expected.to have_subject("Message to #{message.inbox.name} from #{message.sender_name}.") }
      it { is_expected.to deliver_to(inbox.support_staff.first.email) }
      it { is_expected.to reply_to(message.sender_email) }
      it { is_expected.to deliver_from("no-reply@wegotyourback.today") }
      it { is_expected.to have_body_text(message.body) }

      context "when the inbound message is a spam message" do
        let(:message) { FactoryBot.create(:inbound_message, :from_guest_sender, inbox: inbox, spam: true) }
        it { is_expected.to have_subject("[spam?] Message to #{message.inbox.name} from #{message.sender_name}.") }
      end
    end
  end
end
