# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "My Artist"
    gender {Artist::GENDER.sample}
  end
end
