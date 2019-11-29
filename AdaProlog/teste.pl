:- initialization (main).

/*Métodos para calcular taxas gerais*/
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

/*Metodo chamado pelo menu*/
exibeTaxas(Disc) :-
taxasGerais(Disc,[A,R,F]),
write("Media aprovados: "),write(A),writeln("%"),
write("Media reprovados por nota: "),write(R),writeln("%"), 
write("Media reprovados por falta: "),write(F),writeln("%"),
writeln("").

/*Metodos para todas as medias de todos os periodos*/
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

/*Metodos para pegar todas as informações de N periodos para cá*/
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

/*Metodos para pontos criticos*/
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

main :-    
    Y = [[2018.1,6.0,7.0,8.0,50,40,10],[2018.2,6.0,7.0,8.0,50,40,10],[2019.2,6.0,7.0,8.0,50,30,20]],
    transformaArquivo(Y,X),
    writeln('Exibe Taxas'),
    exibeTaxas(X),
    writeln('Exibe Medias'),
    exibeMedias(X),
    writeln('pegaInformacoes'),
    /*ESSE NUMERO TEM Q SER MENOR QUE O LENGTH(X)*/
    pegaInformacoes(X,2),
    writeln('pontoscriticos'),
    pontosCriticos(X).