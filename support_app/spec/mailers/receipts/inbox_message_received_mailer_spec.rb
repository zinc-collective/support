require "rails_helper"
module Receipts
  RSpec.describe InboxMessageReceivedMailer, :type => :mailer do
    describe "notify" do
      let(:message) { FactoryBot.create(:inbound_message, :from_guest_sender) }
      let(:receipt) { FactoryBot.create(:receipt, :inbox_message_received, receiptable: message, via: :email, address: message.sender_email ) }
      subject(:mail) { MessageDeliveredMailer.receipt_email(receipt) }

      it { is_expected.to have_subject("Your message to #{message.inbox.name} has been received.")}
      it { is_expected.to deliver_to(message.sender_email) }
      it { is_expected.to deliver_from("no-reply@example.com") }
      it { is_expected.to have_body_text(/Hello #{message.sender_name},/) }
    end
  end
end