#include <stdio.h>
#include <string>
#include <stdlib.h>
#include <iostream>
#include "prototipos.h" //


using namespace std;

//funcoes
void paginaInicial();
string centralizar(string str);
void menu();
void exibirFuncoesAlunos();
void exibirFuncoesDisciplina();
void importarDados();
void alunos();
void disciplina();
void informacao();

void paginaInicial(){
    system("clear||cls");
    cout << "\n\n";
    cout << centralizar("    |     '||''|.       |     ") + "\n" + centralizar("   |||     ||   ||     |||    ") + "\n" +
    centralizar("  |  ||    ||    ||   |  ||  ") + "\n" + centralizar(" .''''|.   ||    ||  .''''|. ") + "\n" +
    centralizar(".|.  .||. .||...|'  .|.  .||.") + "\n";
    cout << centralizar("analise de dados academicos");
    cout << "\n\n";
    cout << "\t\t\t\t     1.menu\t\t2.info\n\n";
    int opcao;
    do{
        cout << "\t\t\t\t   opcao > ";
        cin >> opcao;
    }while(opcao != 1 && opcao != 2);
    if(opcao == 1){
        menu();
    }else{
        informacao();
    }


}

void importarDados(){
    int diretorioAberto = 0;
    do{
        system("clear||cls");
        cout << "\n\n" << centralizar("informe o diretorio que contem os dados");
        cout << "\n\n" << centralizar("exemplo de diretorio valido:");
        cout << "\n" << centralizar("C:/Users/usuario/caminho/ate/a/pasta");
        cout << "\n\n\t\t\t\t   diretorio > ";
        string diretorio = "";
        cin >> diretorio;
        diretorioAberto = openDirectory(diretorio.c_str());
    }while(diretorioAberto == 0);

}

void alunos(){
    system("clear||cls");
    cout << "\n\n" << centralizar("voce deseja")
    << "\n\n\t\t\t1.importar dados   2.exibir funcoes     3.voltar\n\n";
    int opcao;
    do{
        cout << "\t\t\t\t   opcao > ";
        cin >> opcao;
    }while(opcao != 1 && opcao != 2 && opcao != 3);
    if(opcao == 1){ //importar dados
        importarDados();
    }else if(opcao == 2){ //exibir funcionalidades de aluno
        exibirFuncoesAlunos();
    }else if(opcao == 3){
        menu();
    }

}

void disciplina(){
    system("clear||cls");
    cout << "\n\n" << centralizar("voce deseja")
    << "\n\n\t\t\t1.importar dados   2.exibir funcoes     3.voltar\n\n";
    int opcao;
    do{
        cout << "\t\t\t\t   opcao > ";
        cin >> opcao;
    }while(opcao != 1 && opcao != 2 && opcao != 3);
    if(opcao == 1){ //importar dados
        //importarDados(); // comentei pois nao sei se funciona pq a parte de importar dados de disciplina eh do L.L
    }else if(opcao == 2){ //exibir funcionalidades de aluno
        exibirFuncoesDisciplina();
    }else if(opcao == 3){
        menu();
    }
}

void exibirFuncoesAlunos(){
    system("clear||cls");
    cout << "\n\n" << centralizar("Funcionalidades")
    << "\n\n" << centralizar("1.agrupar alunos de acordo com o CRA passado como parametro")
    << "\n" << centralizar("2.exibir o desempenho dos alunos nos pre requisitos")
    << "\n" << centralizar("3.exibir o desempenho dos alunos nas disciplinas desejaveis")
    << "\n" << centralizar("4.exibir alunos que possuem ao menos n reprovacoes no curriculo")
    << "\n" << centralizar("5.exibir alunos que reprovaram a disciplina");
    int opcao;
    cout << "\n\n\t\t\t\t   opcao > ";
    cin >> opcao;
    switch(opcao){
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    default:
        alunos(); // se digitar algum valor que nao esta entre 1 e 5, volta a pagina anterior
    }
}

void exibirFuncoesDisciplina(){
    system("clear||cls");
    cout << "\n\n" << centralizar("Funcionalidades")
    << "\n\n" << centralizar("1.exibir perfil geral da disciplina de n periodos atras ate hoje")
    << "\n" << centralizar("2.exibir os pontos criticos da disciplina")
    << "\n" << centralizar("3.exibir as medias da disciplina nos periodos passados")
    << "\n" << centralizar("4.exibir indice de aprovacao, reprovacao por falta e nota de cada periodo");
    int opcao;
    cout << "\n\n\t\t\t\t   opcao > ";
    cin >> opcao;
    switch(opcao){
    case 1:
    case 2:
    case 3:
    case 4:
    default:
        disciplina(); // se digitar algum valor que nao esta entre 1 e 5, volta a pagina anterior
    }
}


string centralizar(string str) {
   int espacos = (int)((100 - (int)str.length())/2);
   return string(espacos, ' ') + str + string((espacos + (str.length() > espacos * 2 ? 1 : 0)), ' ');

}

void menu(){
    //opcao menu
    system("clear||cls");
    cout << "\n\n" << centralizar("voce deseja conhecer mais sobre");
    cout << "\n\n\t\t\t\t1.alunos    2.disciplina    3.voltar\n\n";
    int opcao;
    do{
        cout << "\t\t\t\t   opcao > ";
        cin >> opcao;
    }while(opcao != 1 && opcao != 2 && opcao != 3);
    if(opcao == 1){
        alunos();
    }else if(opcao == 2){
        disciplina();
    }else if(opcao == 3){
        paginaInicial();
    }

}

void informacao(){
    system("clear||cls");
    cout << "\n\n " << centralizar("venha conhecer seus alunos ") << "\n\n";
    cout << centralizar("ADA eh uma aplicacao que visa auxiliar o professor em sala de aula de forma ")
         << "\n" << centralizar("que seja repassado para ele uma analise da turma sobre a qual ele ira ")
         << "\n" << centralizar("ministrar. O perfil da turma sera traçado baseado no historico dos alunos e ")
         << "\n" << centralizar("no historico da disciplina.");
    cout << "\n\n " << centralizar("1.voltar") << "\n\n";
    int op;
    do{
      cout << "\t\t\t\t   opcao > ";
      cin >> op;
    }while(op != 1);
    paginaInicial();
}

int main (){
    paginaInicial();
return 0;
}
