class Inbox < ApplicationRecord
  has_many :inbound_messages

  has_many :inbox_permissions
  has_many :support_staff, through: :inbox_permissions, source: :person

  extend FriendlyId
  friendly_id :name, use: :slugged

  def process_inbound_message(inbound_message_params)
    inbound_message_params[:spam] = spam?(inbound_message_params)
    inbound_message = inbound_messages.create(inbound_message_params)
    return inbound_message unless inbound_message.persisted?
    transaction do
      unless inbound_message.spam?
        inbound_message
          .receipts.create!(address: inbound_message.sender_email,
                            topic: :"message.delivered",
                            via: :email).deliver
      end

      support_staff.each do |staff|
        inbound_message
          .receipts.create!(recipient: staff,
                            topic: :"inbox.message.received",
                            address: staff.email, via: :email).deliver
      end

      inbound_message
    end
  end

  def spam?(message_attributes)
    message_attributes[:accept_terms].present?
  end
end
