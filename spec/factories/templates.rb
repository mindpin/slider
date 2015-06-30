FactoryGirl.define do
  factory :template do
    sequence(:title){|n| "title #{n}"}
    sequence(:desc){|n| "desc #{n}"}
  end
end

