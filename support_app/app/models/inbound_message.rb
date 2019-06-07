class InboundMessage < ApplicationRecord
  belongs_to :inbox
  has_many :receipts, as: :receiptable

  # Once we start storing more complex stuff in raw_body, we'll want to
  # do some amount of post-processing to keep the "real body" clean.
  def body
    raw_body
  end
end
