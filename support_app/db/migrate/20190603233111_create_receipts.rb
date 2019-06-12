class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts, id: :uuid do |t|
      t.belongs_to :recipient, type: :uuid
      t.string :topic, null: false
      t.string :status, default: :undelivered
      t.string :address, null: false
      t.string :via, default: :email, null: false
      t.belongs_to :receiptable, type: :uuid, polymorphic: true, null: false
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
