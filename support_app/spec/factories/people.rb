FactoryBot.define do
  factory :guest, class: OpenStruct do
    name { FFaker::Name.name }
    email { "#{name.downcase.tr(" ", "-")}-guest@example.com" }
  end

  factory :person do
    name { FFaker::Name.name }
    email { "#{name.downcase.tr(" ", "-")}@example.com" }
  end
end
