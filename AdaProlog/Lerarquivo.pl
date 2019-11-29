:- use_module(library(csv)).
:- initialization (main).

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

indexOf(V, [H|T], A, I):-
    V = H, A = I, !;
    ANew is A + 1,
    indexOf(V, T, ANew, I).

indexOf(Value, List, Index):-
    indexOf(Value, List, 0, Index).

indexOfWithoutFailure(Value, List, Index):-
    indexOf(Value, List, 0, Index);
    Index = -1.

testaIntervalo([],_,_) :- writeln("").

testaIntervalo([A1|T],Ini,Fim) :-
    nth0(4,A1,C),C >= Ini,C =< Fim,nth0(1,A1,Nome),writeln(Nome),testaIntervalo(T,Ini,Fim);
    testaIntervalo(T,Ini,Fim).

testaRepetenteMatAtual([],_) :- writeln("").

testaRepetenteMatAtual([A1|T],Disc) :-
    member(Disc,A1), nth0(1,A1,Nome),writeln(Nome), testaRepetenteMatAtual(T,Disc);
    testaRepetenteMatAtual(T,Disc).

count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

countall(List,X,C) :-
    member(X,List),
    count(List,X,C);
    C is 0.

contaRepetenciasAluno(Al,Ac,I,Contados,R) :-
length(Al,L), I >= L, R is Ac;
nth0(I,Al,Disc),member(Disc,Contados),I2 is I + 3,contaRepetenciasAluno(Al,Ac,I2,Contados,R);
nth0(I,Al,Disc),I2 is I + 3, countall(Al,Disc,Repet), Repet2 is Repet - 1, Ac2 is Ac + Repet2, 
append(Contados,[Disc],Contados2), contaRepetenciasAluno(Al,Ac2,I2,Contados2,R).

alunosComNRep([],_) :- writeln("").

alunosComNRep([A|T],N) :-
contaRepetenciasAluno(A,0,7,[],R),nth0(1,A,Nome),compara(R,N,T,Nome).

compara(R,N,T,Nome) :-
R >= N, writeln(Nome),alunosComNRep(T,N);
alunosComNRep(T,N).

pegarUltimaApar(El,Lista,Posicao) :-
length(Lista,R), R2 is R - 1, ultimaApr(El,Lista,R2,Posicao).

ultimaApr(_,_,-1,-1).

ultimaApr(El,Lista,I,Posicao) :-
    nth0(I,Lista,X), X = El, Posicao is I + 0;
    I2 is I - 1,ultimaApr(El,Lista,I2,Posicao).

pegaDesempAluno(A,D,R) :-
member(D,A), pegarUltimaApar(D,A,Ind), Ind2 is Ind + 1, nth0(Ind2,A,Nota), R is Nota;
R is -1.

imprimeLista([]) :- write('').
imprimeLista([H|T]) :- writeln(H), imprimeLista(T).

imprimirLista(L) :- length(L,0), writeln('Nenhum');
                    imprimeLista(L).

checaDesempDisc([],D,Ac,Ab,N) :-
    write(D),writeln(':'),
    writeln('Alunos que cursaram com media acima de 7:'),
    imprimirLista(Ac),
    writeln('Alunos que cursaram com media abaixo de 7:'),
    imprimirLista(Ab),
    writeln('Alunos que não cursaram:'),
    imprimirLista(N),
    writeln('').

checaDesempDisc([A|T],D,Ac,Ab,N) :-
pegaDesempAluno(A,D,R), checaDesempAluno(A,T,R,D,Ac,Ab,N).

checaDesempAluno(A,T,R,D,Ac,Ab,N) :-
R =:= -1, nth0(1,A,Nome), append(N,[Nome],N2), checaDesempDisc(T,D,Ac,Ab,N2);
R >= 7, nth0(1,A,Nome), append(Ac,[Nome],Ac2), checaDesempDisc(T,D,Ac2,Ab,N);
nth0(1,A,Nome), append(Ab,[Nome],Ab2), checaDesempDisc(T,D,Ac,Ab2,N).

todoDesemp(_,[]) :- write('').

todoDesemp(Alunos,[D|T]) :-
checaDesempDisc(Alunos,D,[],[],[]), todoDesemp(Alunos,T).

main :-
    varrerDiretorio(["aluno1.csv","aluno2.csv","aluno3.csv"],[],X).
    /*todoDesemp(X,['ESTRUTURA DE DADOS','TEORIA DOS GRAFOS']),
    testaRepetenteMatAtual(X,'TEORIA DOS GRAFOS'),
    testaIntervalo(X,2,9),
    alunosComNRep(X,3).*/

