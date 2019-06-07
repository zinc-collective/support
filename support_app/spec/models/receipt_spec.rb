require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe "#deliver" do
    it "Updates the receipts state" do

      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)
      receipt = Receipt.new(topic: Receipt::TOPICS.first)
      allow(receipt.mailer).to receive(:receipt_email).and_return(double(deliver: true))
      receipt.deliver
      expect(receipt).to be_delivered
      expect(receipt.delivered_at).to eq(current_time)
    end

    context 'when via: :email' do
      let(:mail) { double(deliver: true) }
      subject(:receipt) { Receipt.new(via: via, recipient: nil, topic: topic) }
      let(:via) { :email }

      context "and the topic is :'inbox.message.received'" do
        let(:topic) { :'inbox.message.received' }
        it "sends the receipt from the InboxMessageReceivedReceiptMailer " do
          allow(Receipts::InboxMessageReceivedMailer).to receive(:receipt_email).with(receipt).and_return(mail)
          receipt.deliver
          expect(mail).to have_received(:deliver)
        end
      end

      context "and the topic is :'message.delivered'" do
        let(:topic) { :'message.delivered' }
        it "sends the receipt from the MessageDeliveredMailer " do
          allow(Receipts::MessageDeliveredMailer).to receive(:receipt_email).with(receipt).and_return(mail)
          receipt.deliver
          expect(mail).to have_received(:deliver)
        end
      end

      context "And the topic is invalid" do
        let(:topic) { :'invalid' }

        it "Raises an exception" do
          aggregate_failures do
            expect { receipt.deliver }.to raise_error(Receipt::InvalidTopicError)
            expect(receipt).not_to be_delivered
          end
        end
      end
    end
  end
end
