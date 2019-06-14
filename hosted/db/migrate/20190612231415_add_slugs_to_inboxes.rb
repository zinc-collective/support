class AddSlugsToInboxes < ActiveRecord::Migration[5.2]
  def change
    add_column :inboxes, :slug, :string
    add_index :inboxes, :slug, unique: true
  end
end
