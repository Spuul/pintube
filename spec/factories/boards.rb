FactoryGirl.define do
  factory :board do
    name { Faker::App.name }
    description { Faker::Company.bs }
  end
end
