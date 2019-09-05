#include <dirent.h>
#include <sys/stat.h>

#include <string.h>
#include <stdio.h>
#include <iostream>
#include <string>
#include <fstream>

using namespace std;

//funcoes
void readFile(string path);

void openDirectory(char * dir_name){
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

void readFile(string path){
    fstream myFile;
	myFile.open(path.c_str());

	while(myFile.good()){
		string cell;
		std::getline(myFile, cell, '\n');
		cout << cell << endl;
	}
}


int main() {
 string diretorio = "";
 cout << "digite o diretorio que contem os historicos dos alunos" << endl;
 cin >> diretorio;
 //"C:/Users/Debora/Documents/entradaDados";
 openDirectory( (char*)diretorio.c_str());
 return 0;
}

