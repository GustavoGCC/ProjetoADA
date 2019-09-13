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

int openDirectory(const char * dir_name){
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
           readFile(path, alunos);
           stat(path.c_str(), &info);
           if(S_ISDIR(info.st_mode)){
                openDirectory((char*)path.c_str());
           }
          }
     }

     cout << "\t\t\t\t  dados carregados com sucesso!";
     //3close
     closedir(dir);
     return 1;
}

void readFile(const string path, Alunos a){
    fstream myFile;
	myFile.open(path.c_str());

	while(myFile.good()){
		string cell;
		std::getline(myFile, cell, '\n');
		a.cadastraHistorico(cell);
	}
}

    void Aluno::cadastraDisciplina(string disciplina, double nota){
        if (historico.count(disciplina) == 0)
        {
            historico[disciplina];
            historico[disciplina].push_back(nota);
        }
        else
        {
            historico[disciplina].push_back(nota);
        }
    }

    void Aluno::cadastraMatricula(string mat){
        matricula = mat;
    }


void Alunos::cadastraHistorico(string linha){
    vector<string> dadosAluno = split(linha, ',');
    if (dadosAluno.size() == 2)
    {
        Aluno aluno;
        historicos.insert(pair<string, Aluno>(dadosAluno[0], aluno));
        historicos[dadosAluno[0]].cadastraMatricula(dadosAluno[0]);
    }
    else
    {
        char *pEnd;
        double nota = strtod(dadosAluno[2].c_str(), &pEnd);
        historicos[dadosAluno[0]].cadastraDisciplina(dadosAluno[1], nota);
    }
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


const Alunos returnAlunos(){
    return alunos;
}

/*int main() {
     string diretorio = "";
     cout << "digite o diretorio que contem os historicos dos alunos" << endl;
     cin >> diretorio;
     cout << diretorio;
     openDirectory(diretorio.c_str());
     return 0;
    // "C:/Users/Debora/Documents/PLP/projetoGit/AdaSimulacao/historicosDosAlunos"
}*/


