class CreateInboxPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :inbox_permissions, id: :uuid do |t|
      t.belongs_to :person, type: :uuid
      t.belongs_to :inbox, type: :uuid
      t.timestamps
    end
  end
end
