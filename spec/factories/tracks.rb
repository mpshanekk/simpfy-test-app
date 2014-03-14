# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    name "My Track"
    length 2
    album_id 1
  end
end
