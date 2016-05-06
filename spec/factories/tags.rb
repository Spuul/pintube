FactoryGirl.define do
  factory :tag do
    name { Faker::Book.genre }
    video
  end
end
