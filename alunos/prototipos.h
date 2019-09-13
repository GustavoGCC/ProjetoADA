#ifndef __PROTOTIPOS_H_INCLUDED__   // if x.h hasn't been included yet...
#define __PROTOTIPOS_H_INCLUDED__   //   #define this so the compiler knows it has been included

#include <vector>
#include <map>
//funcoes
using namespace std;
int openDirectory(const char * dir_name);
void cadastraHistorico(string linha);
void cadastraDisciplina(string disciplina, double nota);
void cadastraMatricula(string mat);
const vector<string> split(string frase, const char &c);

struct Aluno{
    string matricula;
    double CRA;
    map<const string, vector<double> > historico;

    void cadastraDisciplina(string disciplina, double nota);
    void cadastraMatricula(string mat);
};

struct Alunos{
    map<string, Aluno> historicos;

    void cadastraHistorico(string linha);
    const vector<string> split(string frase, const char &c);
};

struct Disciplina{
    string nome;
    map<double, vector<double> > estagios;
    map<double, double> indReprovPorFalta;
    map<double, double> indReprovPorNota;
    map<double, double> indAprovados;
};
void readFile(string path, Alunos alunos);

Alunos retornaAlunos();

#endif
