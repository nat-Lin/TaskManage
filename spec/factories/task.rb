FactoryBot.define do
  factory :task do
    title { Faker::Games::Minecraft.achievement }
    start_time { Faker::Time.backward(days: 10, period: :day)}
    end_time { Faker::Time.forward(days: 10, period: :day)}
    user

    trait :long_title do
      title { Faker::Lorem.characters(number: 51) }
    end

    trait :unreasonable do
      start_time { Faker::Time.forward(days: 1) }
      end_time { Faker::Time.backward(days: 1) }
    end

    trait :empty do
      title { nil }
      start_time { nil }
      end_time { nil }
    end
  end
end