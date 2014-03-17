# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    association(:album)
    name "My Track"
    length 2
  end
end
