class Receipt < ApplicationRecord
  TOPICS = [:'inbox.message.received', :'message.delivered']
  belongs_to :receiptable, polymorphic: true
  belongs_to :recipient, optional: true, class_name: :Person

  scope :about, ->(topic) { where(topic: topic) }
  scope :regarding, ->(receiptable) { where(receiptable: receiptable) }
  scope :to, ->(address) { where(address: address) }
  scope :delivered, -> { where.not(delivered_at: nil) }

  def delivered?
    status.to_sym == :delivered && delivered_at.present?
  end

  def deliver
    mailer = case topic&.to_sym
             when :'inbox.message.received'
                Receipts::InboxMessageReceivedMailer
             when :'message.delivered'
                Receipts::MessageDeliveredMailer
             else
              raise InvalidTopicError, topic&.to_sym
             end

    mailer.receipt_email(self).deliver
    update(delivered_at: Time.now, status: :delivered)
  end

  class InvalidTopicError < RuntimeError; end;
end
