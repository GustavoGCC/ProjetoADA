import Diretorio
import System.Directory
import Data.Typeable
import DisciplinasExistentesCC
import ImportaAlunos
import Control.Exception

main :: IO()
main = do
 putStr "\ESC[2J"
 putStrLn(centralizar "abaixo segue uma lista em ordem alfabetica de todas as disciplinas existentes: " ++ "\n")
 exibirDisciplinasExistentes (listarDisciplinasExistentes)
 putStr $ "\n\n"
 putStrLn(centralizar "digite o numero correspondente a sua disciplina: ")
 putStr(centralizar "opcao > " )
 opcao <- getLine
 result <- try (evaluate (read opcao)) :: IO (Either SomeException Int)
 case result of
  Left ex  -> main
  Right val -> do
   let nomeDisciplina = getDisciplinaPeloIndice (read opcao)
   if(nomeDisciplina == "disciplina inexistente") then do
    main
   else do
    let preRequisitos = preRequisitosDeUmaDisciplina(nomeDisciplina)
    disc <- (importarDadosDisciplina nomeDisciplina preRequisitos)
    alunos <- importarDadosAluno
    paginaInicial disc alunos
 
 --paginaInicial disc

exibirDisciplinasExistentes :: [(Integer, String)] -> IO()
exibirDisciplinasExistentes [] = putStr ""
exibirDisciplinasExistentes (d1:d2:d3:ds) = do
 putStr $ (formataString("    " ++ (show (fst d1)) ++ "." ++ snd d1))
 putStr $ (formataString("  " ++ (show (fst d2)) ++ "." ++ snd d2))
 putStrLn $ (formataString("  " ++ (show (fst d3)) ++ "." ++ snd d3))
 exibirDisciplinasExistentes ds

formataString :: String -> String
formataString palavra = palavra ++ replicate (64 - length palavra) ' '
 
paginaInicial :: Disc -> Alunos -> IO()
paginaInicial disciplina alunos = do
 putStr "\ESC[2J"
 putStrLn(centralizar "    |     '||''|.       |     ")
 putStrLn(centralizar "   |||     ||   ||     |||    ")
 putStrLn(centralizar "  |  ||    ||    ||   |  ||   ")
 putStrLn(centralizar " .''''|.   ||    ||  .''''|.  ")
 putStrLn(centralizar ".|.  .||. .||...|'  .|.  .||. ")
 putStrLn(centralizar "analise de dados academicos  " ++ "\n")
 putStrLn("\t\t\t\t     1.menu\t\t2.info\n\n" ++ "\n" )
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", menu disciplina alunos), ("2", informacao)]

verificaEntrada :: String -> [(String, (IO()))] -> IO()
verificaEntrada opcao (x:xs) = verificaEntradaRecursivo opcao (x:xs) (x:xs)

verificaEntradaRecursivo:: String -> [(String, (IO()))] -> [(String, (IO()))] -> IO()
verificaEntradaRecursivo opcao [] (x:xs) = do
 putStr( centralizar "opcao > " )
 palavra <- getLine 
 verificaEntradaRecursivo palavra (x:xs) (x:xs)
verificaEntradaRecursivo opcao (x:xs) (h:t)
 | opcao == (fst x) = snd x
 | otherwise = verificaEntradaRecursivo opcao xs (h:t)

menu :: Disc -> Alunos -> IO()
menu disc dadosAlunos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "voce deseja conhecer mais sobre" ++ "\n")
 putStrLn(centralizar "1.alunos     2.disciplina     3.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", alunos disc dadosAlunos), ("2", (disciplina disc dadosAlunos)), ("3", main)]

informacao :: IO()
informacao = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "\t\tvenha conhecer seus alunos" ++ "\n")
 putStrLn(centralizar "\t\tADA eh uma aplicacao que visa auxiliar o professor em sala de aula de forma ")
 putStrLn(centralizar "\t\t   que seja repassado para ele uma analise da turma sobre a qual ele ira ")
 putStrLn(centralizar "\t\tministrar. O perfil da turma sera tracado baseado no historico dos alunos e ")
 putStrLn(centralizar "\t\tno historico da disciplina." ++ "\n")
 putStrLn(centralizar "\t\t1.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", main)]

alunos :: Disc -> Alunos -> IO()
alunos disc dadosAlunos = do 
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "\tvoce deseja" ++ "\n")
 putStrLn(centralizar "\t1.exibir funcoes     2.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", exibirFuncoesAlunos disc dadosAlunos), ("2", menu disc dadosAlunos) ]

importarDadosAluno :: IO Alunos
importarDadosAluno = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "  informe o diretorio que contem os dados dos alunos" ++ "\n")
 putStrLn(centralizar "exemplo de diretorio valido:")
 putStrLn(centralizar "C:/Users/usuario/caminho/ate/a/pasta" ++ "\n")
 putStr(centralizar "diretorio > " )
 opcao <- getLine
 existe <- doesDirectoryExist opcao
 if existe
  then do
   alunos <- entradaPaginaImportarDadosAluno opcao
   return(alunos)
 else importarDadosAluno

importarDadosDisciplina :: String -> [String] -> IO Disc
importarDadosDisciplina nomeDisciplina preRequisitos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "  informe o diretorio que contem os dados da disciplina" ++ "\n")
 putStrLn(centralizar "exemplo de diretorio valido:")
 putStrLn(centralizar "C:/Users/usuario/caminho/ate/a/pasta" ++ "\n")
 putStr(centralizar "diretorio > " )
 opcao <- getLine
 existe <- doesDirectoryExist opcao
 if existe
  then do
   disc <- entradaPaginaImportarDadosDisciplina opcao nomeDisciplina preRequisitos
   return(disc)
 else importarDadosDisciplina nomeDisciplina preRequisitos

entradaPaginaImportarDadosDisciplina:: String -> String -> [String] -> IO Disc
entradaPaginaImportarDadosDisciplina entrada nomeDisciplina preRequisitos = do
 disc <- lerDisciplinaDeUmDiretorio entrada nomeDisciplina preRequisitos
 return(disc)

entradaPaginaImportarDadosAluno:: String -> IO Alunos
entradaPaginaImportarDadosAluno diretorio = do
 alunos <- lerAlunosDeUmDiretorio diretorio
 return(alunos)

exibirFuncoesAlunos :: Disc -> Alunos -> IO()
exibirFuncoesAlunos disc dadosAlunos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "funcionalidades" ++ "\n")
 putStrLn(centralizar "1.agrupar alunos de acordo com o CRA passado como parametro")
 putStrLn(centralizar "2.exibir o desempenho dos alunos nos pre requisitos")
 putStrLn(centralizar "3.exibir o desempenho dos alunos nas disciplinas desejaveis")
 putStrLn(centralizar "4.exibir alunos que possuem ao menos n reprovacoes no curriculo")
 putStrLn(centralizar "5.exibir alunos que reprovaram a disciplina")
 putStrLn(centralizar "6.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]

funcaoAgruparAlunos :: Disc -> Alunos -> IO()
funcaoAgruparAlunos disc dadosAlunos = do 
 putStrLn("\n\n")
 putStrLn(centralizar "digite o inicio do intervalo do CRA")
 putStr(centralizar "inicio > " )
 intervaloI <- getLine
 putStrLn(centralizar "digite o fim do intervalo do CRA")
 putStr(centralizar "fim > " )
 intervaloF <- getLine
 putStrLn $ ""
 putStrLn(centralizar "os seguintes alunos tem CRA dentro do intervalo passado:")
 putStrLn(alunosNoIntervalo dadosAlunos (read intervaloI :: Double) (read intervaloF :: Double))
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]

desempPreRequisitos :: Disc -> Alunos -> IO()
desempPreRequisitos disc dadosAlunos = do
 let desempenho = (apontaDesempDiscip dadosAlunos (getPrerequisitos disc))
 if(desempenho == "\n") then
  putStrLn $ "essa disciplina nao possui pre requisitos"
 else
  putStrLn(desempenho)
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]


desempDiscDesejaveis :: Disc ->  Alunos -> IO()
desempDiscDesejaveis disc dadosAlunos = do
 exibirDisciplinasExistentes (listarDisciplinasExistentes)
 putStrLn(centralizar "digite o indice da disciplina desejavel ou 'a' para informar que acabou e aperte enter ")
 pegarIndicesDisciplinaDesejaveis disc dadosAlunos []

pegarIndicesDisciplinaDesejaveis :: Disc -> Alunos -> [String] -> IO()
pegarIndicesDisciplinaDesejaveis disc dadosAlunos disciplinasDesejaveis = do
  putStr(centralizar "indice > ")
  disciplina <- getLine
  if (disciplina == "a" )then do
   let desempenho = (apontaDesempDiscip dadosAlunos disciplinasDesejaveis)
   putStrLn(desempenho)
   putStr(centralizar "opcao > " )
   opcao <- getLine 
   verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]
  else do
   result <- try (evaluate (read disciplina)) :: IO (Either SomeException Int)
   case result of
    Left ex  -> do
     pegarIndicesDisciplinaDesejaveis disc dadosAlunos (disciplinasDesejaveis)
    Right val -> do
     let nomeDisciplina = getDisciplinaPeloIndice (read disciplina)
     if(nomeDisciplina == "disciplina inexistente" ) then
      pegarIndicesDisciplinaDesejaveis disc dadosAlunos (disciplinasDesejaveis)
     else do 
      pegarIndicesDisciplinaDesejaveis disc dadosAlunos (disciplinasDesejaveis ++ [nomeDisciplina])
 

repetentesComuns :: Disc -> Alunos -> IO()
repetentesComuns disc dadosAlunos = do
 putStrLn(centralizar "listar os alunos que possuem n reprovacoes no curriculo")
 putStrLn(centralizar "n > ")
 n <- getLine
 result <- try (evaluate (read n)) :: IO (Either SomeException Int)
 case result of
  Left ex  -> repetentesComuns disc dadosAlunos
  Right val -> do
   putStrLn(pegaAlunosReprovacoes dadosAlunos (read n :: Int))
   putStr(centralizar "opcao > " )
   opcao <- getLine 
   verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]

repetentesDisc :: Disc -> Alunos -> IO()
repetentesDisc disc dadosAlunos = do
 let nomeDisciplina = (getNome disc)
 putStrLn((apontaAlunosRepetentes dadosAlunos nomeDisciplina))
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", funcaoAgruparAlunos disc dadosAlunos), ("2", desempPreRequisitos disc dadosAlunos ), ("3", desempDiscDesejaveis disc dadosAlunos), ("4", repetentesComuns disc dadosAlunos), ("5", repetentesDisc disc dadosAlunos), ("6", alunos disc dadosAlunos)]


disciplina :: Disc -> Alunos -> IO()
disciplina disciplina dadosAlunos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "voce deseja" ++ "\n")
 putStrLn(centralizar "1.exibir funcoes    2.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", exibirFuncoesDisciplina disciplina dadosAlunos), ("2", menu disciplina dadosAlunos)]

exibirFuncoesDisciplina :: Disc -> Alunos ->  IO()
exibirFuncoesDisciplina disc dadosAlunos = do
 putStr "\ESC[2J"
 putStrLn("")
 putStrLn(centralizar "funcionalidades" ++ "\n")
 putStrLn(centralizar "1.exibir perfil geral da disciplina de n periodos atras ate hoje")
 putStrLn(centralizar "2.exibir os pontos criticos da disciplina")
 putStrLn(centralizar "3.exibir as medias da disciplina nos periodos passados")
 putStrLn(centralizar "4.exibir indice de aprovacao, reprovacao por falta e nota de cada periodo")
 putStrLn(centralizar "5.voltar" ++ "\n")
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", desempenhoDisc disc dadosAlunos ), ("2", pontosCriticos disc dadosAlunos ), ("3", exibeMediasPassadas disc dadosAlunos), ("4", exibeIndices disc dadosAlunos), ("5", disciplina disc dadosAlunos)]

desempenhoDisc :: Disc -> Alunos -> IO()
desempenhoDisc disc dadosAlunos = do
 putStrLn(centralizar "voce deseja exibir desempenho de de n periodos atras ate hoje")
 putStrLn(centralizar "n > ")
 n <- getLine
 putStrLn(centralizar "Desempenho da disciplina de n periodos atras ate hoje: ")
 putStr $ "\n\n"
 putStr (mostraDados disc (read n))
 putStr $ "\n\n"
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", desempenhoDisc disc dadosAlunos ), ("2", pontosCriticos disc dadosAlunos ), ("3", exibeMediasPassadas disc dadosAlunos), ("4", exibeIndices disc dadosAlunos), ("5", disciplina disc dadosAlunos)]

pontosCriticos :: Disc -> Alunos -> IO()
pontosCriticos disc dadosAlunos = do
 putStrLn(centralizar "pontos criticos da disciplina e informacoes importantes: ")
 putStr $ "\n\n"
 putStr (centralizar (calculaPontosCriticos disc))
 putStr $ "\n\n"
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", desempenhoDisc disc dadosAlunos ), ("2", pontosCriticos disc dadosAlunos ), ("3", exibeMediasPassadas disc dadosAlunos), ("4", exibeIndices disc dadosAlunos), ("5", disciplina disc dadosAlunos)]


exibeMediasPassadas :: Disc -> Alunos -> IO()
exibeMediasPassadas disc dadosAlunos = do 
 putStrLn(centralizar "as medias passadas de cada periodo registrado dessa disciplina sao: ")
 putStr $ "\n\n"
 putStr ((mostraMedias disc))
 putStr $ "\n\n"
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", desempenhoDisc disc dadosAlunos ), ("2", pontosCriticos disc dadosAlunos ), ("3", exibeMediasPassadas disc dadosAlunos), ("4", exibeIndices disc dadosAlunos), ("5", disciplina disc dadosAlunos)]


exibeIndices :: Disc -> Alunos -> IO()
exibeIndices disc dadosAlunos = do
 putStrLn(centralizar "porcentagens de aprovacao e reprovacao da disciplina durante todos os periodos registrados: ")
 putStr $ "\n\n"
 putStr ((mostraIndices disc))
 putStr $ "\n\n"
 putStr(centralizar "opcao > " )
 opcao <- getLine 
 verificaEntrada opcao [("1", desempenhoDisc disc dadosAlunos ), ("2", pontosCriticos disc dadosAlunos ), ("3", exibeMediasPassadas disc dadosAlunos), ("4", exibeIndices disc dadosAlunos), ("5", disciplina disc dadosAlunos)]


centralizar :: String -> String
centralizar palavra = (imprimeEspacos ((espacos palavra)) "") ++ palavra

espacos :: String -> Int
espacos palavra = (((100 - length palavra) `div` 2))

imprimeEspacos :: Int -> String -> String
imprimeEspacos 0 espacos = espacos
imprimeEspacos numEspacos espacos = 
 imprimeEspacos (numEspacos-1) (espacos ++ " ") 