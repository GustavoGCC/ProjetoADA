:- use_module(library(csv)).


lerCsv(File):- 
csv_read_file("./arquivo.csv", File).

varrerDiretorio(Diretorio, Files):-
directory_files(Diretorio, Files).

lerCsvRowList(Lists, L):-
csv_read_file("./arquivo.csv", Rows, []),
rows_to_lists(Rows, Lists),
append([["10", "psoft"], ["10", "java"]], Lists, L).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).
row_to_list(Row, List):-
Row =.. [row|List].
