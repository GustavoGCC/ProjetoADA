module FuncoesDisciplina(
 Disc(Disc),
 mostraIndices,
 -- O que vc deve chamar no metodo M2 no menu
 mostraMedias,
 -- O que vc deve chamar no metodo M3 no menu
 mostraDados,
-- O que vc deve chamar no metodo M4 no menu
 calculaPontosCriticos,
 -- retorna o nome da disciplina
 getNome,
 -- retorna os pre requisitos da disciplina
 getPrerequisitos
) where

import qualified Data.Map as Map
import qualified Data.List as List

--Auxiliares para manipular os mapas
keysMed :: Disc -> [Double]
elemMed :: Disc -> [[Double]]
keysInd :: Disc -> [Double]
elemInd :: Disc -> [[Double]]

--Métodos principais
getPrerequisitos :: Disc -> [String]
getNome :: Disc -> String
tellDisc :: Disc -> [Double]
sizeInd :: Disc -> Int
strTellDisc :: [Double] -> Int -> String
exibeMedias :: [Double] -> [[Double]] -> Int -> String
exibeDados :: [Double] -> [[Double]] -> [[Double]] -> Int -> String
calculaMedReprovFalta :: [Double] -> Int -> Double
checkReprovPorFalta :: Double -> String
chamaReprovFalta :: Disc -> String
transpSomaEst :: Disc -> [Double]
calculaMedPorEst :: [Double] -> Int -> [Double]
estMaisDif :: [Double] -> String
chamaEstMaisDif :: Disc -> String

--Métodos que fazem a interacao direta da disciplina com os metodos que calculam o que se pede
mostraIndices :: Disc -> String
mostraMedias :: Disc -> String
mostraDados :: Disc -> Int -> String
calculaPontosCriticos :: Disc -> String

--"Tipo" disciplina
data Disc = Disc { nome :: String  
            , preReq ::[String] 
            , indicesAprov :: [(Double,[Double])]
            , mediaEstagios :: [(Double,[Double])]
} deriving (Show)

--
getNome (Disc {nome = nomeDisciplina}) = nomeDisciplina

getPrerequisitos (Disc {preReq = preRequisitos}) = preRequisitos

-- Pega o tamanho do mapa de índice (mesmo tamanho do mapa de estágios)
sizeInd (Disc {indicesAprov = i}) = Map.size $ (Map.fromList i)

-- O resultado desse método é [Soma dos indices de aprovacao,Soma dos indices de reprovacao por nota, soma dos indices de reprovacao por falta]
tellDisc (Disc {indicesAprov = i}) = map sum $ List.transpose (Map.elems(Map.fromList i))

-- Método de pegar a porcentagem de aprovados, reprovados por nota e reprovados por falta geral (M1)
strTellDisc x y = "Porcentagem media de aprovados: " ++ show ((x!!0)/(fromIntegral y)) ++ "%" ++ ("\n") ++
                  "Porcentagem media de reprovados por nota: " ++ show ((x!!1)/(fromIntegral y)) ++ "%" ++ ("\n") ++ 
                  "Porcentagem media de reprovados por falta: " ++ show ((x!!2)/(fromIntegral y)) ++ "%" ++ ("\n") ++ ("\n")

-- Metodo que chama o M1
mostraIndices disc = strTellDisc (tellDisc disc) (sizeInd disc)

--Métodos que, respectivamente, pegam as chaves e os elementos do mapa das medias dos estagios
keysMed (Disc {mediaEstagios = i}) = Map.keys $ (Map.fromList i) -- Formato: [periodo,periodo,...]
elemMed (Disc {mediaEstagios = i}) = Map.elems $ (Map.fromList i) --Formato: [[MedEst1,MedEst2,MedEst3],[MedEst1,MedEst2,MedEst3],...]

--Método que exibe as médias das disciplinas nos períodos passados (M2)
exibeMedias k e l
 | l == (List.length k) = ""
 | otherwise = "Periodo: " ++ show (k !! l) ++ ("\n") ++
             "Primeiro Estagio: " ++ show ((e !! l) !! 0) ++ ("\n") ++ 
             "Segundo Estagio: " ++ show ((e !! l) !! 1) ++ ("\n") ++ 
             "Terceiro Estago: " ++ show ((e !! l) !! 2) ++ ("\n") ++ 
             ("\n") ++ (exibeMedias k e (l+1))

--Chama M2
mostraMedias d = exibeMedias (keysMed d) (elemMed d) 0

--Métodos que, respectivamente, pegam as chaves e os elementos do mapa dos indices de aprov
keysInd (Disc {indicesAprov = i}) = Map.keys $ (Map.fromList i) -- Formato: [periodo,periodo,...]
elemInd (Disc {indicesAprov = i}) = Map.elems $ (Map.fromList i) --Formato: [[Aprov,ReprovPorNota,ReprovPorFalta],[Aprov,ReprovPorNota,ReprovPorFalta],...]

--Método que exibe TODOS os dados das disciplinas de n periodos pra cá (M3)
exibeDados kM eM eI l
 | l == (List.length kM) = ""
 | otherwise = "Periodo: " ++ show (kM !! l) ++ ("\n") ++
             "Primeiro Estagio: " ++ show ((eM !! l) !! 0) ++ ("\n") ++ 
             "Segundo Estagio: " ++ show ((eM !! l) !! 1) ++ ("\n") ++ 
             "Terceiro Estago: " ++ show ((eM !! l) !! 2) ++ ("\n") ++
             "Taxa de Aprovados: " ++ show ((eI !! l) !! 0) ++ ("\n") ++
             "Taxa de Reprovados por Nota: " ++ show ((eI !! l) !! 1) ++ ("\n") ++ 
             "Taxa de Reprovados por Falta: " ++ show ((eI !! l) !! 2) ++ ("\n") ++ 
             ("\n") ++ (exibeDados kM eM eI (l+1))

--Método que chama M3
mostraDados d n
    | (n < 1) || (n > (sizeInd d)) = "Numero de periodos invalido"
    |otherwise = exibeDados (keysMed d) (elemMed d) (elemInd d) ((sizeInd d)-n)

--Calcula a média de reprovacao por falta
calculaMedReprovFalta transp size = (transp!!2)/(fromIntegral size)

--Checa se a reprovacao por falta está alta
checkReprovPorFalta med
    | med > 30 = "Indice de reprovacao por faltas muito alto: " ++ show med ++ ("%") ++ ("\n")
    | otherwise = ""

--Chama a checagem de reprovacao por falta
chamaReprovFalta d = checkReprovPorFalta (calculaMedReprovFalta (tellDisc d) (sizeInd d))

--Soma da transposicao dos estagios
transpSomaEst (Disc {mediaEstagios = i}) = map sum $ List.transpose (Map.elems(Map.fromList i))

--Metodo que calcula a media por Estagio
calculaMedPorEst lista tamanho = [(lista!!0)/(fromIntegral tamanho),(lista!!1)/(fromIntegral tamanho),(lista!!2)/(fromIntegral tamanho)]

--Comparacao por Estagios
estMaisDif lista
    | (lista!!0 < lista!!1) && ((lista!!0 < lista!!2)) = "Estagio mais dificil: Primeiro Estagio, com media: " ++ show(lista!!0)
    | (lista!!1 < lista!!0) && ((lista!!1 < lista!!2)) = "Estagio mais dificil: Segundo Estagio, com media: " ++ show(lista!!1)
    | (lista!!2 < lista!!1) && ((lista!!2 < lista!!0)) = "Estagio mais dificil: Terceiro Estagio, com media: " ++ show(lista!!2)
    | (lista!!0 == lista!!1) && ((lista!!0 < lista!!2)) = "Estagios mais dificeis: Primeiro e Segundo estagios, com media: " ++ show(lista!!0)
    | (lista!!0 == lista!!2) && ((lista!!2 < lista!!1)) = "Estagios mais dificeis: Primeiro e Terceiro estagios, com medias respectivas: " ++ show(lista!!0)
    | (lista!!2 == lista!!1) && ((lista!!2 < lista!!0)) = "Estagios mais dificeis: Segundo e Terceiro estagios, com medias respectivas: " ++ show(lista!!1)
    | otherwise = "Estagios com mesma dificuldade, com media:  " ++ show(lista!!0)

--Metodo para chamar a comparacao por Estagios    
chamaEstMaisDif d = (estMaisDif (calculaMedPorEst (transpSomaEst d) (sizeInd d)))

--Método que exibe os pontos criticos que seria o(s) estagio(s) mais dificil(eis) e/ou indice de falta muito alto
calculaPontosCriticos d = (chamaEstMaisDif d) ++ "\n" ++ (chamaReprovFalta d)



main = do
    --let d = Disc "" [] [] []

    let a = Disc "PLP" ["P1","LP1"] [(2018.1,[50.0,10.0,40.0]),(2019.1,[40.0,30.0,30.0])] [(2018.1,[5.0,6.0,8.0]),(2019.1,[4.0,10.0,7.0])]
    -- O que você deve chamar no método M1 no menu
    putStr (mostraIndices a)

    -- O que vc deve chamar no metodo M2 no menu
    putStr (mostraMedias a)

    -- O que vc deve chamar no metodo M3 no menu
    putStr (mostraDados a 1)

    -- O que vc deve chamar no metodo M4 no menu
    putStr (calculaPontosCriticos a)