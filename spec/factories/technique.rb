FactoryGirl.define do
  factory :technique do
    name "Anaconda Choke"
    description "A technique whatever"

    after(:build) do |f|
     f.martial_arts << FactoryGirl.build(:jiu_jitsu)
    end
  end
end