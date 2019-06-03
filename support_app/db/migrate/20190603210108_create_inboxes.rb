class CreateInboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :inboxes, id: :uuid do |t|
      t.string :name
      t.boolean :redirect_on_completion
      t.string :redirect_on_completion_url
      t.text :confirmation_message
      t.timestamps
    end
  end
end
