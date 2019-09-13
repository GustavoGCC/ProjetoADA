#ifndef __PROTOTIPOS_H_INCLUDED__   // if x.h hasn't been included yet...
#define __PROTOTIPOS_H_INCLUDED__   //   #define this so the compiler knows it has been included

#include <vector>
#include <map>
//funcoes

void exibeDesempPass(int nPer, Disciplina d);
void exibeMediasPassadas(Disciplina d);
void exibeIndices(Disciplina d);
vector<double> calculaMediaEstagios(Disciplina d);
void pontosCriticos(Disciplina d);
void agruparAlunos(Alunos a, double iniInter, double fimInter);
void desempPreRequisitos(vector<string> disc, Alunos a);
void desempDiscDesejaveis(vector<string> disc, Alunos a);
void repetentesComuns(int n, Alunos a);
void repetentesDisc(Alunos a, string disciplina);

#endif

