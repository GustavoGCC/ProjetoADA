module ImportaAlunos(
 Alunos(Alunos),
 -- retona um mapa contendo <Matricula, Aluno>
 lerAlunosDeUmDiretorio,
 -- retorna todos os alunos repetentes na disciplina cadastrada do sistema
 apontaAlunosRepetentes,
 -- retorna os alunos que o cra esta no intervalo passado como parametro
 alunosNoIntervalo,
 -- retorna os alunos que possuiem n reprovacoes no curriculo
 pegaAlunosReprovacoes,
 --retorna o desempenho dos alunos nos preRequisitos
 apontaDesempDiscip
) where

import System.IO
import System.Directory
import qualified Data.Map as Map
import qualified Data.List as List

data Alunos = Alunos { alunos :: [(String, Aluno)] 
} deriving (Show)

data Aluno = Aluno { nome :: String  
            , matricula :: String 
            , cra :: Double
            , notas :: [(String,[Double])]
} deriving (Show)

lerAlunosDeUmDiretorio :: String -> IO Alunos
lerAlunosDeUmDiretorio dir = do
 historicosAlunos <- listDirectory dir :: IO [FilePath]
 alunosCadastrados <- abrirArquivo dir historicosAlunos []
 return (Alunos alunosCadastrados)


abrirArquivo :: String -> [FilePath] -> [(String, Aluno)] -> IO [(String, Aluno)]
abrirArquivo dir [] alunos = return alunos
abrirArquivo dir (x:xs) alunos = do
 handle <- openFile (dir++"\\" ++x) ReadMode
 contents <- hGetContents handle
 abrirArquivo dir xs (cadastrarAluno contents alunos)


cadastrarAluno :: String -> [(String, Aluno)] -> [(String, Aluno)]
cadastrarAluno historico alunos = do
 let (dadosPessoais:cra:disciplinasCursadas) = percorrerArquivo historico
 let (matricula:nome:resto) = split dadosPessoais ','
 let (craChave:craValor:resto) = split cra ','
 let notas = extrairNotas disciplinasCursadas []
 alunos ++ [(matricula, criarAluno nome matricula (read craValor) notas)]
 


adicionaAluno :: Aluno -> [Aluno] -> [Aluno]
adicionaAluno aluno alunos = alunos ++ [aluno]

criarAluno :: String -> String -> Double -> [(String, [Double])] -> Aluno
criarAluno nome matricula cra notas = (Aluno nome matricula cra notas)

extrairNotas :: [String] -> [(String, [Double])] -> [(String, [Double])]
extrairNotas [] inicial = inicial
extrairNotas (x:xs) inicial = do
 let (periodo:cadeira:nota:[]) = (split x ',')
 extrairNotas xs (Map.toList (Map.insertWith (++) cadeira [read nota] (Map.fromList inicial)))

percorrerArquivo :: String -> [String]
percorrerArquivo contents = split contents '\n'

split :: String -> Char -> [String]
split [] delim = [""]
split (c:cs) delim
    | c == delim = "" : rest
    | otherwise = (c : head rest) : tail rest
    where
        rest = split cs delim

--Retorna o mapa de alunos
pegaListaAlunos :: Alunos -> [Aluno]
pegaListaAlunos (Alunos {alunos = a}) = Map.elems $ (Map.fromList a);

-- Pega o cra do aluno
pegaCraAluno :: Aluno -> Double
pegaCraAluno (Aluno {cra = c}) = c

--Pega o nome do aluno
pegaNomeAluno :: Aluno -> String
pegaNomeAluno (Aluno {nome = n}) = n

--Pega o nome do aluno
pegaDadosAluno :: Aluno -> String
pegaDadosAluno (Aluno {nome = n, matricula = m, cra = c}) = (n ++ " - matricula: " ++ m ++ " - cra: " ++ (show c))

-- Testa se o cra do aluno ta no intervalo
testaAlunoLimite :: Double -> Double -> Double -> Bool
testaAlunoLimite cra i f
        | (i <= cra) && (cra <= f) = True
        | otherwise = False

--Funcao chamada no menu
alunosNoIntervalo :: Alunos -> Double -> Double -> String
alunosNoIntervalo a i f = varreMapaAlunos (pegaListaAlunos a) i f

-- Funcao principal
varreMapaAlunos :: [Aluno] -> Double -> Double -> String
varreMapaAlunos [] x y = ""
varreMapaAlunos (h:t) i f
        | (testaAlunoLimite (pegaCraAluno h) i f) = (pegaDadosAluno h) ++ "\n" ++ (varreMapaAlunos t i f)
        | otherwise = (varreMapaAlunos t i f)

------------------------------------------------------------
--Pega o tamanho do mapa de notas
sizeNotas :: Aluno -> Int
sizeNotas (Aluno {notas = n}) = Map.size $ (Map.fromList n)

--Pega os elementos do mapa de notas do aluno
pegaListaListaNotas :: Aluno -> [[Double]]
pegaListaListaNotas (Aluno {notas = n}) = Map.elems $ (Map.fromList n);

--Soma o size das listas das listas de nota
somaSizesListas :: [[Double]] -> Int -> Int
somaSizesListas [] i = i
somaSizesListas (h:t) i = i + (List.length h) + (somaSizesListas t i)

-- A diferenca entre os sizes do mapa geral e da soma dos sizes de cada lista eh o numero de reprovacoes
checaAlunosNReprov :: Aluno -> Int -> Bool
checaAlunosNReprov a n 
        | ((somaSizesListas (pegaListaListaNotas a) 0) - (sizeNotas a) > n) = True
        | otherwise = False

-- Metodo chamado no menu
pegaAlunosReprovacoes :: Alunos -> Int -> String
pegaAlunosReprovacoes a i = varreAlunosReprov (pegaListaAlunos a) i

-- Metodo principal
varreAlunosReprov :: [Aluno] -> Int -> String
varreAlunosReprov [] n = ""
varreAlunosReprov (h:t) n
    | (n < 0) = "n invalido" ++ ("\n")
    | (checaAlunosNReprov h n) =  (pegaDadosAluno h) ++ "\n" ++ (varreAlunosReprov t n)
    | otherwise = varreAlunosReprov t n

------------------------------------------------------------
-- Chama o metodo de checagem pra o mapa de notas
checaAlunoReprovDisc :: Aluno -> String -> Bool
checaAlunoReprovDisc (Aluno {notas = n}) s = checaExistDiscAluno n s

--Checa se essa disciplina ja existe no historico do aluno
checaExistDiscAluno :: [(String,[Double])] -> String -> Bool
checaExistDiscAluno m s
        | (Map.lookup s (Map.fromList m) == Nothing) = False
        | otherwise = True

-- Método chamado no menu
apontaAlunosRepetentes :: Alunos -> String -> String
apontaAlunosRepetentes a s = mostraAlunosRepetentes (pegaListaAlunos a) s

--Método principal, recursivo
mostraAlunosRepetentes :: [Aluno] -> String -> String
mostraAlunosRepetentes [] d = ""
mostraAlunosRepetentes (h:t) d
        | (checaAlunoReprovDisc h d) = (pegaDadosAluno h) ++ "\n" ++ (mostraAlunosRepetentes t d)
        |otherwise = (mostraAlunosRepetentes t d)


--Checa numa lista de notas se a última nota é igual ou maior que 7
checaAcSete :: [Double] -> Bool
checaAcSete l 
        | ((last l) >= 7) = True
        | otherwise = False

--Elimina Just
eliminaJust :: Maybe [Double] -> [Double]
eliminaJust (Just a) = a

--Chama a checagem atraves do mapa e da disciplina especifica
checaDisciplinaAcSete :: String -> [(String,[Double])] -> Bool
checaDisciplinaAcSete d m 
    | (Map.lookup d (Map.fromList m)) == Nothing = False
    | otherwise = checaAcSete (eliminaJust((Map.lookup d (Map.fromList m))))

checaNCursou :: [(String,[Double])] -> String -> Bool
checaNCursou n s = ((Map.lookup s (Map.fromList n)) == Nothing)

checaNCursouA :: Aluno -> String -> Bool
checaNCursouA (Aluno {notas = n}) s = ((Map.lookup s (Map.fromList n)) == Nothing)

--Chama a checagem atraves de aluno
alunoDiscAcSete :: Aluno -> String -> Bool
alunoDiscAcSete (Aluno {notas = n}) s = (checaDisciplinaAcSete s n) && (checaNCursou n s == False)

alunosNCursaram :: [Aluno] -> String -> String
alunosNCursaram [] s = ""
alunosNCursaram (h:t) s
        | (checaNCursouA h s) = (pegaNomeAluno h) ++ "\n" ++ (alunosNCursaram t s)
        | otherwise = (alunosNCursaram t s)

alunosDiscAc7 :: [Aluno] -> String -> String
alunosDiscAc7 [] s = ""
alunosDiscAc7 (h:t) s
        | ((alunoDiscAcSete h s) && ((checaNCursouA h s) == False)) = (pegaNomeAluno h) ++ "\n" ++ (alunosDiscAc7 t s)
        | otherwise = (alunosDiscAc7 t s)

alunosDiscAb7 :: [Aluno] -> String -> String
alunosDiscAb7 [] s = ""
alunosDiscAb7 (h:t) s
        | ((alunoDiscAcSete h s) == False && ((checaNCursouA h s) == False)) = (pegaNomeAluno h) ++ "\n" ++ (alunosDiscAb7 t s)
        | otherwise = (alunosDiscAb7 t s)

--Metodo chamado no menu
apontaDesempDiscip :: Alunos -> [String] -> String
apontaDesempDiscip a discs = desempRec (pegaListaAlunos a) discs

desempRec :: [Aluno] -> [String] -> String
desempRec a [] = "\n"
desempRec a (h:t) = "Disciplina: " ++ h ++ " \n" ++ "Alunos que passaram sem final: \n" ++ (alunosDiscAc7 a h) 
                    ++ "Alunos finalistas: \n" ++ (alunosDiscAb7 a h) ++ "Nao cursaram: \n" ++ (alunosNCursaram a h) ++ "\n" ++ (desempRec a t)



main :: IO()
main = do
print $ "passa o dir gata"
dir <- getLine
alunos <- lerAlunosDeUmDiretorio dir
print $ alunos

 --let a1 = Aluno "Maria Marques" "118110000" 8.0 [("P1",[9.0]),("P2",[2.0,8.0]),("P3",[4.0,6.0])]
-- let a2 = Aluno "Joao Silva" "118110002" 6.0 [("P1",[6.0]),("P2",[5.0]),("LEDA",[3.0,6.0])]
 --let a3 = Aluno "Andre Mourao" "118110001" 7.0 [("P1",[7.0]),("P2",[5.0]),("LEDA",[10.0])]
 --let as = Alunos [("118110000",a1),("118110002",a2),("118110001",a3)]
 --putStr (alunosNoIntervalo as 6.0 7.1)
 --putStr (apontaAlunosRepetentes as "LEDA")
