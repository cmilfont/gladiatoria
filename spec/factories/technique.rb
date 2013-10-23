FactoryGirl.define do
  factory :technique do
    name "Anaconda Choke"
    description "A technique whatever"

    after(:build) do |f|
     f.martial_arts << FactoryGirl.build(:jiu_jitsu)
    end
  end

  factory :gola_rodada, class: Technique do
    name "Gola rodada"
    description "Apaga mas não bate"

    after(:build) do |f|
     f.martial_arts << FactoryGirl.build(:jiu_jitsu)
    end
  end
end