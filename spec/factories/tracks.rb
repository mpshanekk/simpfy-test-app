# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    name "MyString"
    length "MyString"
    album_id 1
  end
end