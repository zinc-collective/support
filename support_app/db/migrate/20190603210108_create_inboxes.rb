class CreateInboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :inboxes, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :redirect_on_completion, default: false
      t.string :redirect_on_success_url
      t.string :redirect_on_failure_url
      t.text :confirmation_message
      t.timestamps
    end
  end
end
