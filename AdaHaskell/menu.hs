main :: IO()
main = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "    |     '||''|.       |     ")
 putStrLn(centralizar "   |||     ||   ||     |||    ")
 putStrLn(centralizar "  |  ||    ||    ||   |  ||  ")
 putStrLn(centralizar " .''''|.   ||    ||  .''''|. ")
 putStrLn(centralizar ".|.  .||. .||...|'  .|.  .||.")
 putStrLn(centralizar " analise de dados academicos" ++ "\n")
 putStrLn(centralizar "\t1.menu\t\t2.info" ++ "\n" )
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 entradaPaginaInicial opcao

entradaPaginaInicial:: String -> IO()
entradaPaginaInicial "1" = menu
entradaPaginaInicial "2" = informacao
entradaPaginaInicial entrada = do
 putStr(centralizar "opcao > " )
 palavra <- getLine 
 entradaPaginaInicial palavra

menu :: IO()
menu = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "voce deseja conhecer mais sobre" ++ "\n")
 putStrLn("\t\t\t1.alunos     2.disciplina     3.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 entradaPaginaMenu opcao

entradaPaginaMenu:: String -> IO()
entradaPaginaMenu "1" = alunos
entradaPaginaMenu "2" = disciplina
entradaPaginaMenu "3" = main
entradaPaginaMenu entrada = do
 putStr(centralizar "opcao > " )
 palavra <- getLine 
 entradaPaginaMenu palavra

informacao :: IO()
informacao = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "\t\tvenha conhecer seus alunos" ++ "\n")
 putStrLn("\t\tADA eh uma aplicacao que visa auxiliar o professor em sala de aula de forma ")
 putStrLn("\t\t   que seja repassado para ele uma analise da turma sobre a qual ele ira ")
 putStrLn("\t\tministrar. O perfil da turma sera tracado baseado no historico dos alunos e ")
 putStrLn(centralizar "\t\tno historico da disciplina." ++ "\n")
 putStrLn(centralizar "\t\t\t1.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 entradaPaginaInformacao opcao

entradaPaginaInformacao:: String -> IO()
entradaPaginaInformacao "1" = main
entradaPaginaInformacao entrada = do
 putStr(centralizar "opcao > " )
 palavra <- getLine 
 entradaPaginaInformacao palavra


alunos :: IO()
alunos = do 
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "\t      voce deseja" ++ "\n")
 putStrLn("\t\t1.importar dados\t2.exibir funcoes\t3.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 entradaPaginaAlunos opcao

entradaPaginaAlunos:: String -> IO()
entradaPaginaAlunos "1" = importarDados
entradaPaginaAlunos "2" = putStrLn $ "exibir funcoes"
entradaPaginaAlunos "3" = menu
entradaPaginaAlunos entrada = do
 putStr(centralizar "opcao > " )
 palavra <- getLine 
 entradaPaginaAlunos palavra

importarDados :: IO()
importarDados = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn("\t\t        informe o diretorio que contem os dados" ++ "\n")
 putStrLn("\t\t\t     exemplo de diretorio valido:")
 putStrLn("\t\t         C:/Users/usuario/caminho/ate/a/pasta" ++ "\n")
 putStrLn(centralizar "\t\t1.voltar" ++ "\n")
 putStr(centralizar "diretorio > " )
 diretorio <- getLine
 entradaPaginaImportarDados diretorio

entradaPaginaImportarDados:: String -> IO()
entradaPaginaImportarDados "1" = alunos
entradaPaginaImportarDados entrada = putStrLn $ "importar dados"

exibirFuncoesAlunos :: IO()
exibirFuncoesAlunos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "funcionalidades" ++ "\n")
 putStrLn("\t\t1.agrupar alunos de acordo com o CRA passado como parametro")
 putStrLn("\t\t    2.exibir o desempenho dos alunos nos pre requisitos")
 putStrLn("\t\t3.exibir o desempenho dos alunos nas disciplinas desejaveis")


disciplina :: IO()
disciplina = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "\t      voce deseja" ++ "\n")
 putStrLn("\t\t1.importar dados\t2.exibir funcoes\t3.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 entradaPaginaDisciplina opcao

entradaPaginaDisciplina:: String -> IO()
entradaPaginaDisciplina "1" = putStrLn $ "importar dados"
entradaPaginaDisciplina "2" = putStrLn $ "exibir funcoes"
entradaPaginaDisciplina "3" = menu
entradaPaginaDisciplina entrada = do
 putStr(centralizar "opcao > " )
 palavra <- getLine 
 entradaPaginaDisciplina palavra

centralizar :: String -> String
centralizar palavra = "                            " ++ palavra

centralizarRecursiva :: String -> String
centralizarRecursiva palavra = "                            " ++ palavra


