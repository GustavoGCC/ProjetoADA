#include <dirent.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <fstream>
#include "prototipos.h"


using namespace std;

//funcoes


Alunos alunos; // variavel global alunos
Disciplina disciplina;

int openDirectory(const char * dir_name, int opcao){
     DIR *dir; //pointer to open directory
     struct dirent *entry; //stuff inside the direct
     struct stat info; //information about each entry

     //1 open
     dir = opendir(dir_name);
     if (!dir) {
      cout << "\n\t\t\t\t  diretorio nao encontrado\n";
      return 0;
    }
     //2read
     while ((entry = readdir(dir)) != NULL)
     {
          if (entry->d_name[0] != '.')
          {
           string path = string(dir_name) + '/' + string(entry->d_name);
           if(opcao == 0 ){
              readFile(path);

           }else if(opcao == 1){
                readD(path);
           }
           stat(path.c_str(), &info);
           if(S_ISDIR(info.st_mode)){
                openDirectory((char*)path.c_str(), opcao);
           }
          }
     }

     cout << "\t\t\t\t  dados carregados com sucesso!";
     //3close
     closedir(dir);
     return 1;
}

void readFile(const string path){
    fstream myFile;
	myFile.open(path.c_str());
    string cell;

    string matricula;
    int cont = 0;
	while(myFile.good()){
		std::getline(myFile, cell, '\n');
		if(cont == 0){
            matricula = cell.substr(0,9);
            cont++;
        }
		alunos.cadastraHistorico(cell, matricula);
	}
}

void readD(const string path){
    fstream myFile;
	myFile.open(path.c_str());
    string cell;

	while(myFile.good()){
		std::getline(myFile, cell, '\n');
		disciplina.cadastraDis(cell);
	}
}

vector<string> spl(string frase, const char &c){
    string buff = "";
    vector<string> saida;

    for (int i = 0; i < frase.length(); i++)
    {
        if (frase[i] != c)
            buff += frase[i];
        else if (frase[i] == c && buff != "")
        {
            saida.push_back(buff);
            buff = "";
        }
    }
    if (buff != "")
    {
        saida.push_back(buff);
    }
    return saida;
}

void Disciplina::cadastraDis(string linha){
    vector<string> dadosDisciplina = spl(linha, ',');
    /*if(dadosDisciplina.size() == 1){
        disciplina.periodos.insert(pair<string, Aluno>(dadosDisciplina[0], aluno));
    }*/
    cout << dadosDisciplina[0];
   /* Disciplina disciplina;
    if (dadosAluno.size() == 1){
        disciplina.periodos.insert(pair<string, Aluno>(dadosDisciplina[0], dadosDisciplina[1]));
    }else{
        disciplina.estagios = dadosDisciplina.size() -1;

    }*/
}
/*
void mediaPeriodos(vector<string> notas){
    double mediaAllPeriodos;
    double mediaPeriodo;
    for (std::vector<int>::iterator it = notas.begin() ; it != notas.end(); ++it){
        char *pEnd;
        double nota = strtod((*it).c_str(), &pEnd);
        mediaPeriodo += nota;

    }
        std::cout << ' ' << *it;


}*/

void Aluno::cadastraDisciplina(string disciplina, double nota){
    if (historico.count(disciplina) == 0)
    {

        historico[disciplina];
        historico[disciplina].push_back(nota);
        //cout << historico[disciplina][0];
    }
    else
    {
        historico[disciplina].push_back(nota);

    }
}

    void Aluno::cadastraMatricula(string mat){
        matricula = mat;
    }

void Alunos::tes(){
    cout << "TO AQUI";
}


void Alunos::cadastraHistorico(string linha, string matricula){

    vector<string> dadosAluno = split(linha, ',');
    if (dadosAluno.size() == 2)
    {   Aluno aluno;
        if(dadosAluno[0] == "CRA"){
            char *pEnd;
            double cra = strtod(dadosAluno[1].c_str(), &pEnd);
            //aluno.CRA = cra;
            //historicos.insert(pair<string, Aluno>(dadosAluno[0], aluno));
            historicos[matricula].CRA = cra;
            //cout << aluno.CRA << "\n";
        }else{
            historicos.insert(pair<string, Aluno>(dadosAluno[0], aluno));
            historicos[dadosAluno[0]].cadastraMatricula(dadosAluno[0]);
        }

    }
    else
    {
        char *pEnd;
        double nota = strtod(dadosAluno[2].c_str(), &pEnd);
        historicos[matricula].cadastraDisciplina(dadosAluno[1], nota);
    }
}
    map<string, Aluno> Alunos::historicoS(){
        return historicos;
    }

const vector<string> Alunos::split(string frase, const char &c){
    string buff = "";
    vector<string> saida;

    for (int i = 0; i < frase.length(); i++)
    {
        if (frase[i] != c)
            buff += frase[i];
        else if (frase[i] == c && buff != "")
        {
            saida.push_back(buff);
            buff = "";
        }
    }
    if (buff != "")
    {
        saida.push_back(buff);
    }
    return saida;
}


Alunos returnAlunos(){
    return alunos;
}

/*int main() {
     string diretorio = "";
     cout << "digite o diretorio que contem os historicos dos alunos" << endl;
     cin >> diretorio;
     cout << diretorio;
     openDirectory(diretorio.c_str());
     return 0;
    // "C:/Users/Debora/Documents/plpGit/ProjetoADA/AdaSimulacao/historicosDosAlunos"
    // "C:/Users/Debora/Documents/PLP/ProjetoGit/projetoADA/AdaSimulacao/historicosDosAlunos"
    //"C:/Users/Debora/Documents/PLP/ProjetoGit/projetoADA/AdaSimulacao/historicoDisciplina"
}*/


