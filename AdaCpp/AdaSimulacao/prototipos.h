#ifndef __PROTOTIPOS_H_INCLUDED__   // if x.h hasn't been included yet...
#define __PROTOTIPOS_H_INCLUDED__   //   #define this so the compiler knows it has been included

#include <vector>
#include <map>
//funcoes
using namespace std;
int openDirectory(const char * dir_name, int opcao);
void readD(const string path);
void cadastraHistorico(string linha, string matricula);
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

    void cadastraHistorico(string linha, string matricula);
    void tes();
    const vector<string> split(string frase, const char &c);
    map<string, Aluno> historicoS();
};

struct Disciplina{
    //string nome;
    map<int, vector<double> > periodos;
    //string periodo;
    map<double, vector<double> > estagios;

    map<double, double> indReprovPorFalta;
    map<double, double> indReprovPorNota;
    map<double, double> indAprovados;
    void cadastraDis(string linha);
    void mediaPeriodos();

};
void readFile(string path);
Alunos returnAlunos();
void tes();
map<string, Aluno> historicoS();
void cadastraDis(string linha);
void mediaPeriodos();
Disciplina returnDisciplina();

#endif
