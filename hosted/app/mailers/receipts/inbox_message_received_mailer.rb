module Receipts
  class InboxMessageReceivedMailer < ApplicationMailer
    def receipt_email(receipt)
      subject = "Message to #{receipt.receiptable.inbox.name} from #{receipt.receiptable.sender_name}."
      subject = "[spam?] #{subject}" if receipt.receiptable.respond_to?(:spam?) && receipt.receiptable.spam?
      mail(to: receipt.address, reply_to: receipt.receiptable.sender_email,
           subject: subject,
           body: receipt.receiptable.raw_body)
    end
  end
end
