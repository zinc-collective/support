module Receipts
  class MessageDeliveredMailer < ApplicationMailer
    def receipt_email(receipt)
      @receipt = receipt
      mail(to: receipt.receiptable.sender_email,
           subject: "Your message to #{receipt.receiptable.inbox.name} has been received.")
    end
  end
end
