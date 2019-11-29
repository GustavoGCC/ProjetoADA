:- use_module(library(csv)).
:- initialization (main).

main():-
tab(9000),nl,nl,
tab(15),
write("Digite o diretorio que contem os dados dos alunos\n"),
tab(25),
write("exemplo de diretorio valido:\n"),
tab(28),
write("./caminho/ate/a/pasta\n"),
read(DiretorioA),
nl,
abrirDiretorio(DiretorioA, Historicos),
tab(15),
write("Digite o diretorio que contem os dados da disciplina\n"),
tab(25),
write("exemplo de diretorio valido:\n"),
tab(28),
write("./caminho/ate/a/pasta\n"),
read(DiretorioD),
nl,
lerArquivoD(DiretorioD, HistoricoDisciplina),
transformaArquivo(HistoricoDisciplina, DadosDisciplina),
nl,tab(15),
write("Digite o numero correspondente a sua disciplina:"),
nl,
exibirTodasAsDisciplinas(DisciplinaAtual),
write(DisciplinaAtual),
ada(Historicos, DisciplinaAtual, DadosDisciplina).

exibirTodasAsDisciplinas(DisciplinaAtual):-
atom_concat("./DisciplinasExistentes/","disciplinasExistentes.csv", Res),
csv_read_file(Res, Rows, []),
rows_to_lists(Rows, Lista),
exibirDisciplinasFormatadas(Lista, 1, IndiceDisciplinaAtual),
recuperarDisciplinaPeloIndice(Lista, IndiceDisciplinaAtual, DisciplinaAtual).

exibirDisciplinasFormatadas([], _, IndiceDisciplinaAtual):- nl, read(IndiceDisciplinaAtual).
exibirDisciplinasFormatadas([[D]|L], Indice, IndiceDisciplinaAtual):-
write("  "),
write(Indice), write(". "), write(D), I2 is Indice + 1, (I2 mod 3 =:= 0 -> write("\n"), exibirDisciplinasFormatadas(L, I2, IndiceDisciplinaAtual);
exibirDisciplinasFormatadas(L, I2, IndiceDisciplinaAtual)).

recuperarDisciplinaPeloIndice([[D]|_], 1, Result):- atom_concat("'", D,R), atom_concat(R, "'", Result).
recuperarDisciplinaPeloIndice([[D]|L],Indice, DisciplinaAtual):- I is Indice -1, recuperarDisciplinaPeloIndice(L, I, DisciplinaAtual).

ada(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,nl,
tab(15),
write("    |     '||''|.       |     \n"),
tab(15),
write("   |||     ||   ||     |||    \n"),
tab(15),
write("  |  ||    ||    ||   |  ||  \n"),
tab(15),
write(" .''''|.   ||    ||  .''''|. \n"),
tab(15),
write(".|.  .||. .||...|'  .|.  .||.\n"),
tab(15), write(" analise de dados academicos\n"),
tab(21), write("1.menu"), tab(5), write("2.info\n\n"),
tab(25), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> menu(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 2 -> info(Historicos, DisciplinaAtual, DadosDisciplina);
ada(Historicos, DisciplinaAtual, DadosDisciplina)).

menu(Historicos, DisciplinaAtual, DadosDisciplina):- 
tab(8000),nl,
tab(34), write("voce deseja conhecer mais sobre \n\n"),
tab(32), write("1.alunos    2.disciplina    3.voltar"),nl, nl,
tab(46), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> alunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 2 -> disciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 3 -> ada(Historicos, DisciplinaAtual, DadosDisciplina);
menu(Historicos, DisciplinaAtual, DadosDisciplina)).

info(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,
tab(34), write("venha conhecer seus alunos \n\n"),
tab(10), write("ADA eh uma aplicacao que visa auxiliar o professor em sala de aula de forma \n"),
tab(13), write("que seja repassado para ele uma analise da turma sobre a qual ele ira \n"),
tab(10), write("ministrar. O perfil da turma sera traçado baseado no historico dos alunos e \n"),
tab(35), write("no historico da disciplina.\n"),
tab(44), write("1.voltar"), nl,
read(Opcao),
(Opcao == 1 -> ada(Historicos, DisciplinaAtual, DadosDisciplina);
info(Historicos, DisciplinaAtual, DadosDisciplina)).

alunos(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,
tab(48), write("voce deseja\n\n"),
tab(32), write("1.exibir funcoes     2.voltar"),nl, nl,
tab(50), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 2 -> menu(Historicos, DisciplinaAtual, DadosDisciplina, DadosDisciplina);
alunos(Historicos, DisciplinaAtual, DadosDisciplina)).

exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,
tab(44), write("funcionalidades\n\n"),
tab(20), write("1.agrupar alunos de acordo com o CRA passado como parametro\n"),
tab(24), write("2.exibir o desempenho dos alunos nos pre requisitos\n"),
tab(21), write("3.exibir o desempenho dos alunos nas disciplinas desejaveis\n"),
tab(19), write("4.exibir alunos que possuem ao menos n reprovacoes no curriculo\n"),
tab(28), write("5.exibir alunos que reprovaram a disciplina\n"),
tab(43), write("6.voltar\n"), nl, nl,
tab(44), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> write("Digite o inicio do intervalo > "), nl, read(N1), 
	write("Digite o fim do intervalo > "), nl, read(N2), testaIntervalo(Historicos, N1, N2),
	nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(op),
	exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 2 ->  tab(44), write("Digite os pre requisitos no formato [disc1, disc2..]"), nl, read(Desejaveis),
	todoDesemp(Historicos, Desejaveis), nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(op),
	exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 3 -> tab(44), write("Digite as disciplinas desejáveis no formato [disc1, disc2..]"), nl, read(Desejaveis),
	todoDesemp(Historicos, Desejaveis), nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(op),
	exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 4 -> tab(44), write("Digite a quantidade de reprovações > "),nl,
	read(N), alunosComNRep(Historicos, N), exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 5 -> testaRepetenteMatAtual(Historicos, DisciplinaAtual);
Opcao == 6 -> alunos(Historicos, DisciplinaAtual, DadosDisciplina);
exibirFuncoesAlunos(Historicos, DisciplinaAtual, DadosDisciplina)).


disciplina(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,
tab(48), write("voce deseja\n\n"),
tab(32), write("1.importar dados   2.exibir funcoes     3.voltar"),nl, nl,
tab(50), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> write("importar dados");
Opcao == 2 -> exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 3 -> menu(Historicos, DisciplinaAtual, DadosDisciplina);
disciplina(Historicos, DisciplinaAtual, DadosDisciplina)).

exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina):-
tab(8000),nl,
tab(44), write("funcionalidades\n\n"),
tab(20), write("1.exibir perfil geral da disciplina de n periodos atras ate hoje\n"),
tab(30), write("2.exibir os pontos criticos da disciplina\n"),
tab(24), write("3.exibir as medias da disciplina nos periodos passados\n"),
tab(16), write("4.exibir indice de aprovacao, reprovacao por falta e nota de cada periodo\n"),
tab(47), write("5.voltar\n"), nl, nl,
tab(47), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> tab(20), write("voce deseja exibir desempenho de de n periodos atras ate hoje\n"),
			tab(20),write(" n > "), nl, read(N), pegaInformacoes(DadosDisciplina, N),
			nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(Op),
			exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 2 -> pontosCriticos(DadosDisciplina),
			nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(Op),
			exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 3 -> exibeMedias(DadosDisciplina),
			nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(Op),
			exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 4 -> exibeTaxas(DadosDisciplina),
			nl, write("aperte uma tecla para exibir funcionalidades novamente > "), nl, read(Op),
			exibirFuncoesDisciplina(Historicos, DisciplinaAtual, DadosDisciplina);
Opcao == 5 -> disciplina(Historicos, DisciplinaAtual, DadosDisciplina);
exibirFuncoesDisciplina()).


###########funcoes para ler arquivos####################################

lerCsv(Arquivo, File) :- 
csv_read_file(Arquivo, File).

lerArquivoD(Path, HistoricoDisciplina):-
atom_concat(Path, "disciplina.csv", Res),
csv_read_file(Res, Rows, []),
rows_to_lists(Rows, HistoricoDisciplina).

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

todoDesemp(_,[]) :- write("").

todoDesemp(Alunos,[D|T]) :-
checaDesempDisc(Alunos,D,[],[],[]), todoDesemp(Alunos,T).





calculaTaxas([(_,[A,R,F|_])|[]],SomaAprov,SomaReprov,SomaFalta,Quant,Retorno) :-
SomaAprov2 is SomaAprov + A, SomaReprov2 is SomaReprov + R,SomaFalta2 is SomaFalta + F, Quant2 is Quant + 1,
MediaAprov is SomaAprov2/Quant2,
MediaReprov is SomaReprov2/Quant2,
MediaFalt is SomaFalta2/Quant2,
Retorno = [MediaAprov,MediaReprov,MediaFalt].

calculaTaxas([(_,[A,R,F|_])|T],SomaAprov,SomaReprov,SomaFalta,Quant,Retorno) :-
SomaAprov2 is SomaAprov + A, 
SomaReprov2 is SomaReprov + R,
SomaFalta2 is SomaFalta + F, 
Quant2 is Quant + 1,
calculaTaxas(T,SomaAprov2,SomaReprov2,SomaFalta2,Quant2,Retorno).

taxasGerais(Disc,Retorno) :- nth0(3,Disc,Lista), calculaTaxas(Lista,0,0,0,0,Retorno).


exibeTaxas(Disc) :-
taxasGerais(Disc,[A,R,F]),
write("Media aprovados: "),write(A),writeln("%"),
write("Media reprovados por nota: "),write(R),writeln("%"), 
write("Media reprovados por falta: "),write(F),writeln("%"),
writeln("").


mediasDisciplina([(P,[R,S,T])|[]]) :-
write("Periodo: "),writeln(P),
write("Media primeiro estagio: "),writeln(R),
write("Media segundo estagio: "),writeln(S),
write("Media terceiro estagio: "),writeln(T),
writeln("").

mediasDisciplina([(P,[R,S,T])|Tail]) :-
write("Periodo: "),writeln(P),
write("Media primeiro estagio: "),writeln(R),
write("Media segundo estagio: "),writeln(S),
write("Media terceiro estagio: "),writeln(T),
writeln(""),
mediasDisciplina(Tail).

exibeMedias(X) :-
    nth0(2,X,Lista), mediasDisciplina(Lista).


pegaInformacoes(_,0) :- writeln("").

pegaInformacoes(X,N) :-
nth0(2,X,Notas),nth0(3,X,Taxas),nth0(N,Notas,(P,[R,S,T])), nth0(N,Taxas,(P,[A,E,F])),
write("Periodo: "),writeln(P),
write("Media primeiro estagio: "),writeln(R),
write("Media segundo estagio: "),writeln(S),
write("Media terceiro estagio: "),writeln(T),
write("Media aprovados: "),write(A),writeln("%"),
write("Media reprovados por nota: "),write(E),writeln("%"), 
write("Media reprovados por falta: "),write(F),writeln("%"),
writeln(""),
N2 is N - 1,
pegaInformacoes(X,N2).


faltaCritica(Disc) :-
taxasGerais(Disc,[_,_,F]), F > 30, write("Indice de faltas muito alto: "),write(F),writeln("%"),writeln('');
writeln("").

calculaMedias([(_,[A,R,F|_])|[]],SomaPrim,SomaSeg,SomaTerc,Quant,Retorno) :-
SomaPrim2 is SomaPrim + A, SomaSeg2 is SomaSeg + R,SomaTerc2 is SomaTerc + F, Quant2 is Quant + 1,
MediaPrim is SomaPrim2/Quant2,
MediaSeg is SomaSeg2/Quant2,
MediaTerc is SomaTerc2/Quant2,
Retorno = [MediaPrim,MediaSeg,MediaTerc].

calculaMedias([(_,[A,R,F|_])|T],SomaPrim,SomaSeg,SomaTerc,Quant,Retorno) :-
SomaPrim2 is SomaPrim + A, SomaSeg2 is SomaSeg + R,SomaTerc2 is SomaTerc + F, Quant2 is Quant + 1,
calculaTaxas(T,SomaPrim2,SomaSeg2,SomaTerc2,Quant2,Retorno).

mediasGerais(Disc,Retorno) :- nth0(2,Disc,Lista),calculaMedias(Lista,0,0,0,0,Retorno).

pontosCriticos(Disc) :-
mediasGerais(Disc,[P,S,T]), P > S, P > T, writeln("O primeiro estágio é o mais difícil."),faltaCritica(Disc);
mediasGerais(Disc,[P,S,T]), S > P, S > T, writeln("O segundo estágio é o mais difícil."),faltaCritica(Disc);
mediasGerais(Disc,[P,S,T]), T > S, T > P, writeln("O terceiro estágio é o mais difícil."),faltaCritica(Disc);
mediasGerais(Disc,[P,S,T]), P =:= S, P > T, writeln("O primeiro estágio e o segundo estágios são mais difíceis."),faltaCritica(Disc);
mediasGerais(Disc,[P,S,T]), P > S, P =:= T, writeln("O primeiro estágio e o terceiro estágios são mais difíceis."),faltaCritica(Disc);
mediasGerais(Disc,[P,S,T]), T =:= S, T > P, writeln("O segundo estágio e o terceiro estágio são mais difíceis."),faltaCritica(Disc);
writeln("Os estágios possuem a mesma dificuldade"),faltaCritica(Disc).

transformaArquivo(X,R) :-
    pegaNotas(X,[],N),pegaTaxas(X,[],S),R = [".",["."],N,S].

pegaNotas([],Ac,Ac).
pegaNotas([P|T],Ac,N) :-
    nth0(0,P,Sem),nth0(1,P,E1),nth0(2,P,E2),nth0(3,P,E3),append(Ac,[(Sem,[E1,E2,E3])],Ac2),pegaNotas(T,Ac2,N).

pegaTaxas([],Ac,Ac).
pegaTaxas([P|T],Ac,N) :-
    nth0(0,P,Sem),nth0(4,P,E1),nth0(5,P,E2),nth0(6,P,E3),append(Ac,[(Sem,[E1,E2,E3])],Ac2),pegaTaxas(T,Ac2,N).






requisitos('ADMINISTRACAO',[]).
requisitos(ADMINISTRACAO DE SISTEMAS,[]).
requisitos("ADMINISTRACAO DE SISTEMAS DE INFORMACAO",[]).
requisitos('ALGEBRA LINEAR I',['FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO II']).
requisitos("ALGORITMOS AVANCADOS I",[]).
requisitos("ALGORITMOS AVANCADOS II",[]).
requisitos("ALGORITMOS AVANCADOS III",[]).
requisitos("ANALISE DE SISTEMAS",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("ANALISE E TECNICAS DE ALGORITMOS",["ESTRUTURA DE DADOS", "LABORATORIO DE ESTRUTURA DE DADOS"]).
requisitos("APLICACOES DE GRAFOS",[]).
requisitos("APLICACOES DE PLP",[]).
requisitos("AVALIACAO DE DESEMPENHO DE SISTEMAS DISCRETOS", []).
requisitos("BANCO DE DADOS 1",["ESTRUTURA DE DADOS"]).
requisitos("BANCO DE DADOS 2",["BANCO DE DADOS 1"]).
requisitos("BASQUETEBOL FEM",[]).
requisitos("BASQUETEBOL MAS",[]).
requisitos("CALCULO DIFERENCIAL E INTEGRAL I",["FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO I"]).
requisitos("CALCULO DIFERENCIAL E INTEGRAL II",["FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO II", "CALCULO DIFERENCIAL E INTEGRAL I"]).
requisitos("CALCULO NUMERICO",[]).
requisitos("CIENCIA DE DADOS DESCRITIVA").
requisitos("CIENCIA DE DADOS PREDITIVA",[]).
requisitos("COMPILADORES",["PARADIGMAS DE LINGUAGENS DE PROGRAMACAO"]).
requisitos("DESENVOLVIMENTO DE APLICACOES CORPORATIVAS AVANCADAS",[]).
requisitos("DIREITO E CIDADANIA",[]).
requisitos("ECONOMIA",[]).
requisitos("ECONOMIA DE TECNOLOGIA DA INFORMACAO",[]).
requisitos("EMPREENDEDORISMO",[]).
requisitos("EMPREENDEDORISMO EM SOFTWARE",[]).
requisitos("ENGENHARIA DE SOFTWARE",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("ESTAGIO INTEGRADO",[]).
requisitos("ESTAGIO INTEGRADO I",[]).
requisitos("ESTAGIO INTEGRADO II",[]).
requisitos("ESTAGIO INTEGRADO III",[]).
requisitos("ESTATISTICA APLICADA",["INTRODUCAO A PROBABILIDADE"]).
requisitos("ESTRUTURA DE DADOS",["PROGRAMACAO 2","LABORATORIO DE PROGRAMACAO 2"]).
requisitos("FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO I",[]).
requisitos("FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO II",["FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO I"]).
requisitos("FUNDAMENTOS DE PROGRAMACAO CONCORRENTE",[]).
requisitos("FUTSAL",[]).
requisitos("GERENCIA DE REDES DE COMPUTADORES",[]).
requisitos("GESTAO DE PROJETOS",[]).
requisitos("GESTAO DE SISTEMAS DE INFORMACAO",[]).
requisitos("GOVERNANCIA DA INTERNET",[]).
requisitos("INFORMATICA E SOCIEDADE",[]).
requisitos("INGLES",[]).
requisitos("INTELIGENCIA ARTIFICIAL",["TEORIA DA COMPUTACAO"]).
requisitos("INTERCONEXAO DE REDES DE COMPUTADORES",[]).
requisitos("INTRODUCAO A BANCO DE DADOS E MINERACAO DE DADOS",[]).
requisitos("INTRODUCAO A CIENCIA DA COMPUTACAO",[]).
requisitos("INTRODUCAO A COMPUTACAO",[]).
requisitos("INTRODUCAO A PROBABILIDADE",["FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO II", "CALCULO DIFERENCIAL E INTEGRAL I"]).
requisitos("JOGOS DIGITAIS",[]).
requisitos("LABORATORIO DE ENGENHARIA DE SOFTWARE",[]).
requisitos("LABORATORIO DE ESTRUTURA DE DADOS",["PROGRAMACAO 2","LABORATORIO DE PROGRAMACAO 2"]).
requisitos("LABORATORIO DE INTERCONEXAO DE REDES DE COMPUTADORES",[]).
requisitos("LABORATORIO DE ORGANIZACAO E ARQUITETURA DE COMPUTADORES",["INTRODUCAO A COMPUTACAO"]).
requisitos("LABORATORIO DE PROGRAMACAO 1",[]).
requisitos("LABORATORIO DE PROGRAMACAO 2",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("LEITURA E PRODUCAO DE TEXTO",[]).
requisitos("LINGUA PORTUGUESA",[]).
requisitos("LOGICA PARA COMPUTACAO",["FUNDAMENTOS DE MATEMATICA PARA CIENCIA DA COMPUTACAO II", "CALCULO DIFERENCIAL E INTEGRAL I"]).
requisitos("METODOLOGIA CIENTIFICA",[]).
requisitos("METODOS E SOFTWARE NUMERICOS",[]).
requisitos("METODOS ESTATISTICOS",[]).
requisitos("ORGANIZACAO E ARQUITETURA DE COMPUTADORES",["INTRODUCAO A COMPUTACAO"]).
requisitos("PARADIGMAS DE LINGUAGENS DE PROGRAMACAO",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("PERCEPCAO COMPUTACIONAL",[]).
requisitos("PRATICA DE ENSINO DE COMPUTACAO I",[]).
requisitos("PRATICA DE ENSINO DE COMPUTACAO II",[]).
requisitos("PRINCIPIOS DE DESENVOLVIMENTO WEB",[]).
requisitos("PROGRAMACAO 1",[]).
requisitos("PROGRAMACAO 2",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("PROGRAMACAO CONCORRENTE",["SISTEMAS OPERACIONAIS"]).
requisitos("PROGRAMACAO FUNCIONAL",[]).
requisitos("PROJETO DE REDES DE COMPUTADORES",[]).
requisitos("PROJETO DE SISTEMAS OPERACIONAIS",[]).
requisitos("PROJETO DE SOFTWARE",["PROGRAMACAO 1","LABORATORIO DE PROGRAMACAO 1"]).
requisitos("PROJETO DE TRABALHO DE CONCLUSAO DE CURSO",[]).
requisitos("PROJETO EM COMPUTACAO 1",["ENGENHARIA DE SOFTWARE"]).
requisitos("PROJETO EM COMPUTACAO 2",["PROJETO EM COMPUTACAO 1"]).
requisitos("RECUPERACAO DA INFORMACAO E BUSCA NA WEB",[]).
requisitos("REDES DE COMPUTADORES",["INTRODUCAO A COMPUTACAO"]).
requisitos("SEMINARIOS",[]).
requisitos("SEMINARIOS [EDUCACAO AMBIENTAL]",[]).
requisitos("SISTEMAS DE APOIO A DECISAO",[]).
requisitos("SISTEMAS DE INFORMACAO II",[]).
requisitos("SISTEMAS DE RECUPUPERACAO DA INFORMACAO",[]).
requisitos("SISTEMAS OPERACIONAIS",["LABORATORIO DE ORGANIZACAO E ARQUITETURA DE COMPUTADORES"]).
requisitos("SOCIOLOGIA INDUSTRIAL I",[]).
requisitos("TECNICAS DE PROGRAMACAO",[]).
requisitos("TEORIA DA COMPUTACAO",["PARADIGMAS DE LINGUAGENS DE PROGRAMACAO"]).
requisitos("TEORIA DOS GRAFOS",[]).
requisitos("TRABALHO DE CONCLUSAO DE CURSO",["PROJETO DE TRABALHO DE CONCLUSAO DE CURSO"]).
requisitos("VERIFICACAO E VALIDACAO DE SOFTWARE",[]).
requisitos("VISAO COMPUTACIONAL",[]).
requisitos("VISUALIZACAO DE DADOS",[]).