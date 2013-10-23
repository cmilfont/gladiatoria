require 'factory_girl'
Dir[Rails.root.join("#{Rails.root}/spec/factories/**/*.rb")].each {|f| require f}

Technique.destroy_index
Technique.create_index

FactoryGirl.create :technique
FactoryGirl.create :technique, :name => "Mata Leão"
FactoryGirl.create :technique, :name => "Katagatame"
FactoryGirl.create :technique, :name => "Triangulo Voador"