require 'integration_helper'	
feature "Cadastro de Técnicas", %q(
	Para buscar a técnica por texto
	Como um administrador do sistema
	Eu quero cadastrar uma técnica
) do
	background do
		@sanda = FactoryGirl.create(:gola_rodada)
	end

	scenario "Cadastrar tecnica" do
		visit new_technique_path
		fill_in "Name", with: "Gola rodada"
		fill_in "Description", with: "Apaga mas não bate"	
		all('#technique_martial_art_ids_ option')[0].select_option
		click_on "Cadastrar"
		expect(page).to have_content "Cadastrada com sucesso"
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
		expect(page).to have_content "Apaga mas não bate"
	end
end