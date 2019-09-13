class AddHoneytrapToInbox < ActiveRecord::Migration[5.2]
  def change
    add_column :inboxes, :honeytrap, :boolean, default: false, null: false
    add_column :inbound_messages, :spam, :boolean, default: false, null: false
  end
end
