# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    title "My Title"
    genre {Album::GENRE.sample}
  end
end
