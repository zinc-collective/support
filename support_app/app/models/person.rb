class Person < ApplicationRecord
  has_many :inbox_permissions
  has_many :inboxes, through: :inbox_permissions
  has_many :received_receipts, class_name: :Receipt, foreign_key: :recipient_id

  def email_for(inbox)
    email
  end
end
