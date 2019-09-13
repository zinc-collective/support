class InboundMessage < ApplicationRecord
  belongs_to :inbox

  # HoneyTrap
  attr_accessor :accept_terms

  has_many :receipts, as: :receiptable

  validates_presence_of :sender_email
  validates_presence_of :sender_name

  # Once we start storing more complex stuff in raw_body, we'll want to
  # do some amount of post-processing to keep the "real body" clean.
  def body
    raw_body
  end
end
