FactoryBot.define do
  factory :guest, class: OpenStruct do
    name { FFaker::Name.name }
    email { "#{name.gsub(' ', '-')}@example.com" }
  end

  factory :person do
    name { FFaker::Name.name }
    email { "#{name.gsub(' ', '-')}@example.com" }
  end
end
