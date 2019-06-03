class CreateInboundMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :inbound_messages, id: :uuid do |t|
      t.belongs_to :inbox, type: :uuid
      t.belongs_to :sender, type: :uuid
      t.string :status, default: :received
      t.string :sender_name
      t.string :sender_email
      t.text :raw_body

      t.datetime :received_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
end
