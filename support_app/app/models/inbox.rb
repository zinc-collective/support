class Inbox < ApplicationRecord
  has_many :inbound_messages

  has_many :inbox_permissions
  has_many :support_staff, through: :inbox_permissions, source: :person

  def process_inbound_message(inbound_message_params)
    inbound_message = inbound_messages.create(inbound_message_params)
    transaction do
      inbound_message
        .receipts.create!(address: inbound_message.sender_email,
                          topic: :"message.delivered",
                          via: :email).deliver

      support_staff.each do |staff|
        inbound_message
          .receipts.create!(recipient: staff,
                            topic: :"inbox.message.received",
                            address: staff.email, via: :email).deliver
      end

      inbound_message
    end
  end
end
