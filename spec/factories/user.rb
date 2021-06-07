FactoryBot.define do
  factory :user do 
    name { Faker::Name.unique.name }
    password { 'password' }

    trait :empty do
      name { nil }
      password { nil }
    end
  end
end