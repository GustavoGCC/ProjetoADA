:- use_module(library(csv)).


lerCsv(Arquivo, File) :- 
csv_read_file(Arquivo, File).

abrirDiretorio(Diretorio,Files, Res, Lists):-
directory_files(Diretorio, Files),
subtract(Files, ['.', '..'], Res),
varrerDiretorio(Res, Lists).


varrerDiretorio([X|[]], Lists):- lerArquivo(X, Lists).
varrerDiretorio([X|L1], Lists):-
lerArquivo(X, Lists),
varrerDiretorio(L1, Lists).

lerArquivo(Arquivo, Lists):-
atom_concat("./historicosDosAlunos/",Arquivo, Res),
csv_read_file(Res, Rows, []),
rows_to_lists(Rows, Lists).

lerCsvRowList(Lists):-
 csv_read_file("./arquivo.csv", Rows, []),
 rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
 Row =.. [row|List].