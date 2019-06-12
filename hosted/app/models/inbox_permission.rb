class InboxPermission < ApplicationRecord
  belongs_to :person
  belongs_to :inbox
end
