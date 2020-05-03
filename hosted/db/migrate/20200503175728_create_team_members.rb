class CreateTeamMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_members, id: :uuid do |t|
      # Slugs are a way to identify what intent a particular
      # object in the system has in a human-friendly way.
      # See: https://en.wikipedia.org/wiki/Slug_(publishing)
      #      and https://en.wikipedia.org/wiki/Clean_URL#Slug
      t.string :public_schedule_slug, index: { name: "public_schedule_slug"}, null: false, unique: true
      t.string :public_schedule_availability_email_address, index: { name: "public_schedule_availability_email" } , null: false, unique: true
      t.timestamps
    end
  end
end
