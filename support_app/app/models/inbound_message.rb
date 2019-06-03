class InboundMessage < ApplicationRecord
  belongs_to :inbox
  has_many :receipts, as: :receiptable
end
