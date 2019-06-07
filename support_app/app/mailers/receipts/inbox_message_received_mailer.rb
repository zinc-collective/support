module Receipts
  class InboxMessageReceivedMailer < ApplicationMailer
    def receipt_email(receipt)
      mail(to: receipt.address, reply_to: receipt.receiptable.sender_email,
           subject: "Message to #{receipt.receiptable.inbox.name} from #{receipt.receiptable.sender_name}.",
           body: receipt.receiptable.raw_body)
    end
  end
end