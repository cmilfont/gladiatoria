require 'integration_helper'	
feature "Cadastro de Técnicas", %q(
	Para buscar a técnica por texto
	Como um administrador do sistema
	Eu quero cadastrar uma técnica
) do
	background do
		@sanda = FactoryGirl.create(:technique)
	end

	scenario "Cadastrar tecnica" do
		visit new_technique_path
		fill_in "Name", with: "Anaconda Choke"
		fill_in "Description", with: "A technique whatever"	
		all('#technique_martial_art_ids_ option')[0].select_option
		click_on "Cadastrar"
		expect(page).to have_content "Anaconda Choke"
	end

	scenario "Listar tecnicas" do
		visit techniques_path
		expect(page).to have_content "Techniques"
	end

	scenario "Remover tecnica" do
		visit techniques_path
		click_on "Destroy"
		expect(page).to have_no_content("Anaconda Choke")
	end

	scenario "Editar tecnica" do
		visit techniques_path
		click_on "Edit"
		expect(page).to have_content "A technique whatever"
	end
end