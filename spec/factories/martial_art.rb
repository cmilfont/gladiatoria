FactoryGirl.define do
  factory :martial_art do
	name "Sanda"
    description "Soco chute queda"
  end

  factory :jiu_jitsu, class: MartialArt do
	name "Jiu Jitsu"
    description "Arte suave de dar nó nas pessoas"
  end
end