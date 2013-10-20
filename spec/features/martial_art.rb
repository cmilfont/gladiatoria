require 'integration_helper'	
feature "Cadastro de Artes Marciais", %q(
	Para oferecer uma maneira de categorizar as tecnicas.
	Como um administrador
	Eu quero cadastrar uma arte marcial
) do
	background do
		@sanda = FactoryGirl.create(:martial_art)
	end

	scenario "Cadastrar arte marcial" do
		visit new_martial_art_path
		fill_in "Name", with: "Sanda"
		fill_in "Description", with: "Soco chute queda"	
		click_on "Cadastrar"
		expect(page).to have_content "Sanda"
	end

	scenario "Listar arte marcial" do
		visit martial_arts_path
		expect(page).to have_content "Artes Marciais"
	end

	scenario "Remover arte marcial" do
		visit martial_arts_path
		click_on "Destroy"
		expect(page).to have_no_content("Sanda")
	end

	scenario "Editar arte marcial" do
		visit martial_arts_path
		click_on "Edit"
		expect(page).to have_content "Soco chute queda"
	end
end