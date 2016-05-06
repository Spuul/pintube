FactoryGirl.define do
  factory :video do
    identifier { [*('a'..'z'), *('0'..'9')].sample(19).join }
    published_at { Faker::Time.between(DateTime.now + 30, DateTime.now) }
    channel_id { [*('a'..'z'), *('0'..'9')].sample(19).join }
    title { Faker::Superhero.name }
    description { Faker::Lorem.paragraph(2) }
    thumbnail { Faker::Avatar.image }
    channel_title { Faker::App.name }
    category_id { "#{Random.new.rand(9000)}" }
  end
end
