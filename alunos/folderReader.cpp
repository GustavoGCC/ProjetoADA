#include <dirent.h>
#include <sys/stat.h>

#include <string.h>
#include <stdio.h>
#include <iostream>
#include <string>
#include <fstream>
#include "estruturaAlunos.cpp" // eh o arquivo que contem as estruturas e esta em dev

using namespace std;

//funcoes
void readFile(string path);
void cadastraHistorico(string cell);

void openDirectory(const char * dir_name){
    cout << "akjsjha" ;
     DIR *dir; //pointer to open directory
     struct dirent *entry; //stuff inside the direct
     struct stat info; //information about each entry

     //1 open
     dir = opendir(dir_name);
     if (!dir) {
      cout << "Directory was not found";
      return;
    }

     //2read
     while ((entry = readdir(dir)) != NULL)
     {
          if (entry->d_name[0] != '.')
          {
           string path = string(dir_name) + '/' + string(entry->d_name);
           readFile(path);
           stat(path.c_str(), &info);
           if(S_ISDIR(info.st_mode)){
                openDirectory((char*)path.c_str());
           }
          }
     }

     //3close
     closedir(dir);
}

void readFile(const string path){
    Alunos alunos;
    fstream myFile;
	myFile.open(path.c_str());

	while(myFile.good()){
		string cell;
		std::getline(myFile, cell, '\n');
		alunos.cadastraHistorico(cell);
	}
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


