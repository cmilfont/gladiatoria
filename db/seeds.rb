require 'factory_girl'
Dir[Rails.root.join("#{Rails.root}/spec/factories/**/*.rb")].each {|f| require f}

Technique.destroy_index
Technique.create_index

FactoryGirl.create :technique
FactoryGirl.create :technique, :title => "Mata Leão"
FactoryGirl.create :technique, :title => "Katagatame"
FactoryGirl.create :technique, :title => "Triangulo Voador"