#include <stdio.h>
#include <string>
#include <stdlib.h>
#include <iostream>
#include "folderReader.cpp" // esse import que da erro
                            //importa o arquivo que contem as funcoes de ler arquivo

//funcoes
int paginaInicial();
string centralizar(string str);
void menu();

int paginaInicial(){
    cout << "\n";
    cout << centralizar("    |     '||''|.       |     ") + "\n" + centralizar("   |||     ||   ||     |||    ") + "\n" +
    centralizar("  |  ||    ||    ||   |  ||  ") + "\n" + centralizar(" .''''|.   ||    ||  .''''|. ") + "\n" +
    centralizar(".|.  .||. .||...|'  .|.  .||.") + "\n";
    cout << centralizar("analise de dados academicos");
    cout << "\n\n";
    cout << "\t\t\t\t     1.menu\t\t2.info\n\n";
    int opcao;
    cout << "\t\t\t\t   opcao > ";
    cin >> opcao;
    return opcao;
}

void alunos(){
    system("clear||cls");
    cout << "\n\n" << centralizar("informe o diretorio que contem os dados dos alunos");
    cout << "\n\n" << centralizar("exemplo de diretorio valido:");
    cout << "\n" << centralizar("C:/Users/usuario/caminho/ate/a/pasta");
    cout << "\n\n\t\t\t\t   diretorio > ";
    string diretorio;
    cin >> diretorio;
    openDirectory(diretorio.c_str());
}


string centralizar(string str) {
   int espacos = (int)((100 - (int)str.length())/2);
   return string(espacos, ' ') + str + string((espacos + (str.length() > espacos * 2 ? 1 : 0)), ' ');

}

void menu(){
    int opcao = paginaInicial();
    if(opcao==1){
        system("clear||cls");
        cout << "\n\n" << centralizar("voce deseja conhecer mais sobre");
        cout << "\n\n\t\t\t\t    1.alunos\t2.disciplina\n\n";
        cout << "\t\t\t\t   opcao > ";
        cin >> opcao;
        if(opcao == 1){
            alunos();
        }else{

        }
    }else{

    }

}

int main (){
    menu();

return 0;
}
