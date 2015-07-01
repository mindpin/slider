FactoryGirl.define do
  factory :story do
    sequence(:title){|n| "title #{n}"}
    sequence(:desc){|n| "desc #{n}"}
    sequence(:html_body){|n| "html_body #{n}"}
    sequence(:edit_html_body){|n| "edit_html_body #{n}"}
  end

end
