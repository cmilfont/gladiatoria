require 'integration_helper'

feature "Busca por Técnica", %q{
  Para listar minhas técnicas com marcação das palavras buscadas
  Como um usuário
  Eu quero buscar por texto
} do

  background do
    Technique.destroy_index
    Technique.create_index
    FactoryGirl.create :technique
    FactoryGirl.create :technique, name: "Mata leão"
    FactoryGirl.create :technique, name: "katagatame", description: "Apaga mas não bate"
  end

  scenario "Busca por texto" do
    visit search_techniques_path
    fill_in "query", with: "Katagatame"
    click_on "Search"
    expect(page).to have_content "Apaga mas não bate"
  end


end