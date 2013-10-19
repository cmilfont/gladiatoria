feature "Busca por Técnica", %q{
  Para listar minhas técnicas com marcação das palavras buscadas
  Como um usuário
  Eu quero buscar por texto
} do

  background do
  #Dado que eu tenha técnicas cadastradas e indexadas pelo título, descrição
  end

  scenario "Busca por texto" do

    visit search_path
    fill_in "query", with: "Anaconda Choke"
    expect(page).to have_content ""

    #Dado que eu estou na tela de busca
    #Quando eu inserir "Anaconda Choke"
    #Então eu deveria ver a lista
    #|Titulo |
    #|Anaconda Choke |
    #|Anaconda NOGI |

  end


end