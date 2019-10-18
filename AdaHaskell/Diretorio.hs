module Diretorio(
 lerDisciplinaDeUmDiretorio,
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

import System.IO
import System.Directory
import FuncoesDisciplina
import Control.Monad  

lerDisciplinaDeUmDiretorio :: String -> String -> [String] -> IO Disc
lerDisciplinaDeUmDiretorio dir nomeDisciplina preRequisitos = do
 fileNames <- listDirectory dir :: IO [FilePath]
 disc <- abrirArquivoDiscplina dir fileNames nomeDisciplina preRequisitos
 return(disc)

abrirArquivoDiscplina :: String -> [FilePath] -> String -> [String] -> IO Disc
abrirArquivoDiscplina dir nomeArquivos nomeDisciplina preRequisitos = do
 handle <- openFile (dir++"\\" ++ head nomeArquivos) ReadMode  
 contents <- hGetContents handle
 disc <- cadastrarDisciplina nomeDisciplina preRequisitos (extrairTodosOsIndices(percorrerArquivo contents) []) (extrairTodosAsMedias(percorrerArquivo contents) [])
 return(disc)

percorrerArquivo :: String -> [String]
percorrerArquivo contents = split contents '\n'

cadastrarDisciplina :: String -> [String] -> [(Double, [Double])] -> [(Double, [Double])] -> IO Disc
cadastrarDisciplina nome preRequisitos indices medias = return (Disc nome preRequisitos indices medias)

split :: String -> Char -> [String]
split [] delim = [""]
split (c:cs) delim
    | c == delim = "" : rest
    | otherwise = (c : head rest) : tail rest
    where
        rest = split cs delim

main = do
 print $ extrairTodosOsIndices ["2018.1,6.0,7.0,8.0,50,40,10","2018.2,6.0,7.0,8.0,50,40,10","2019.1,6.0,7.0,8.0,50,40,10","2019.2,6.0,7.0,8.0,50,40,10"] []
 print $ extrairTodosAsMedias ["2018.1,6.0,7.0,8.0,50,40,10","2018.2,6.0,7.0,8.0,50,40,10","2019.1,6.0,7.0,8.0,50,40,10","2019.2,6.0,7.0,8.0,50,40,10"] []
 --cadastraDisciplinaNoArquivo "PLP" ["P1","LP1"] [(2018.1,[50.0,10.0,40.0]),(2019.1,[40.0,30.0,30.0])] [(2018.1,[5.0,6.0,8.0]),(2019.1,[4.0,10.0,7.0])]

extrairTodosOsIndices :: [String] -> [(Double, [Double])] -> [(Double, [Double])]
extrairTodosOsIndices [] inicial = inicial
extrairTodosOsIndices (x:xs) inicial = inicial ++ extrairTodosOsIndices xs (extrairIndices (split x ','))

extrairIndices :: [String] -> [(Double, [Double])]
extrairIndices (p:n1:n2:n3:i1:i2:i3:[]) = [(read p, [read i1, read i2, read i3])]

extrairTodosAsMedias :: [String] -> [(Double, [Double])] -> [(Double, [Double])]
extrairTodosAsMedias [] inicial = inicial
extrairTodosAsMedias (x:xs) inicial = inicial ++ extrairTodosAsMedias xs (extrairMedias (split x ','))

extrairMedias :: [String] -> [(Double, [Double])]
extrairMedias (p:m1:m2:m3:i1:i2:i3:[]) = [(read p, [read m1, read m2, read m3])]

importarPreRequisitosDisciplina :: String -> [String]
importarPreRequisitosDisciplina "PLP" = ["P1", "LP1"]