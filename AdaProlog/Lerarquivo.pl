:- use_module(library(csv)).


lerCsv(Arquivo, File) :- 
csv_read_file(Arquivo, File).

abrirDiretorio(Diretorio, Hitoricos):-
directory_files(Diretorio, Files),
subtract(Files, ['.', '..'], Files2),
varrerDiretorio(Files2, [], Hitoricos).


varrerDiretorio([X|[]], Lists, Res):- lerArquivo(X, Lista2),
append([Lista2], Lists, Res).
varrerDiretorio([X|L1], Lists, Res):-
varrerDiretorio(L1, Lists, Res2),
lerArquivo(X, Lista2),
append(Res2, [Lista2] , Res).


testaFuncao(Lista, Variavel , L):-
append(Lista, Variavel, L).


lerArquivo(Arquivo, Retorno):-
atom_concat("./historicosDosAlunos/",Arquivo, Res),
csv_read_file(Res, Rows, []),
rows_to_lists(Rows, Lista),
concatenarDadosDeAluno(Lista, [], Retorno).

concatenarDadosDeAluno([A|[]], Anterior, Retorno):- append(Anterior, A, Retorno).
concatenarDadosDeAluno([A|L], Anterior, Retorno):-
append(Anterior, A, Retorno2),
concatenarDadosDeAluno(L, Retorno2, Retorno).


lerCsvRowList(Lists):-
 csv_read_file("./arquivo.csv", Rows, []),
 rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
 Row =.. [row|List].