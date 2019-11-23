:- initialization main.

main:-
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
(Opcao == 1 -> menu();
Opcao == 2 -> info();
main()).

menu():- 
tab(8000),nl,
tab(34), write("voce deseja conhecer mais sobre \n\n"),
tab(32), write("1.alunos    2.disciplina    3.voltar"),nl, nl,
tab(46), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> alunos();
Opcao == 2 -> disciplina();
Opcao == 3 -> main();
menu()).

info():-
tab(8000),nl,
tab(34), write("venha conhecer seus alunos \n\n"),
tab(10), write("ADA eh uma aplicacao que visa auxiliar o professor em sala de aula de forma \n"),
tab(13), write("que seja repassado para ele uma analise da turma sobre a qual ele ira \n"),
tab(10), write("ministrar. O perfil da turma sera traçado baseado no historico dos alunos e \n"),
tab(35), write("no historico da disciplina.\n"),
tab(44), write("1.voltar"), nl,
read(Opcao),
(Opcao == 1 -> main();
info()).

alunos():-
tab(8000),nl,
tab(48), write("voce deseja\n\n"),
tab(32), write("1.importar dados   2.exibir funcoes     3.voltar"),nl, nl,
tab(50), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> write("importar dados");
Opcao == 2 -> exibirFuncoesAlunos();
Opcao == 3 -> menu();
alunos()).

exibirFuncoesAlunos():-
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
(Opcao == 1 -> write("f1");
Opcao == 2 -> write("f2");
Opcao == 3 -> write("f3");
Opcao == 4 -> write("f4");
Opcao == 5 -> write("f5");
Opcao == 6 -> alunos();
exibirFuncoesAlunos()).


disciplina():-
tab(8000),nl,
tab(48), write("voce deseja\n\n"),
tab(32), write("1.importar dados   2.exibir funcoes     3.voltar"),nl, nl,
tab(50), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> write("importar dados");
Opcao == 2 -> exibirFuncoesDisciplina();
Opcao == 3 -> menu();
disciplina()).

exibirFuncoesDisciplina():-
tab(8000),nl,
tab(44), write("funcionalidades\n\n"),
tab(20), write("1.exibir perfil geral da disciplina de n periodos atras ate hoje\n"),
tab(30), write("2.exibir os pontos criticos da disciplina\n"),
tab(24), write("3.exibir as medias da disciplina nos periodos passados\n"),
tab(16), write("4.exibir indice de aprovacao, reprovacao por falta e nota de cada periodo\n"),
tab(47), write("5.voltar\n"), nl, nl,
tab(47), write("opcao > "), nl, 
read(Opcao),
(Opcao == 1 -> write("f1");
Opcao == 2 -> write("f2");
Opcao == 3 -> write("f3");
Opcao == 4 -> write("f4");
Opcao == 5 -> disciplina();
exibirFuncoesDisciplina()).
