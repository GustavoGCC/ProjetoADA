#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <sstream>
#include <stdlib.h>

using namespace std;

//funcoes prototipos
void cadastraHistorico(string linha);
void cadastraDisciplina(string disciplina, double nota);
void cadastraMatricula(string mat);
const vector<string> split( string frase, const char& c);

struct Aluno {
    std::string matricula;
    double CRA;
    std::map<const std::string, vector<double> > historico;

    void cadastraDisciplina(string disciplina,double nota){
        if(historico.count(disciplina) == 0){
            historico[disciplina];
            historico[disciplina].push_back(nota);
        }else{
            historico[disciplina].push_back(nota);
        }
    }

    void cadastraMatricula(string mat){
        matricula = mat;
    }


};

struct Alunos {
    std::map<std::string, Aluno> historicos;

    void cadastraHistorico(string linha){
        vector<string> dadosAluno = split(linha, ',');
        if(dadosAluno.size() == 2){
            Aluno aluno;
            historicos.insert(pair<string, Aluno>(dadosAluno[0], aluno));
            historicos[dadosAluno[0]].cadastraMatricula(dadosAluno[0]);
        }else{
            char* pEnd;
            double nota = strtod (dadosAluno[2].c_str(), &pEnd);
            historicos[dadosAluno[0]].cadastraDisciplina(dadosAluno[1], nota);
        }
    }

    const vector<string> split( string frase, const char& c){
        string buff = "";
        vector<string> saida;

        for(int i = 0; i < frase.length() ; i++){
            if(frase[i] != c) buff += frase[i];
            else if(frase[i] == c && buff != "") {
                saida.push_back(buff);
                buff = "";
            }
        }
        if(buff != "") {
            saida.push_back(buff);
        }
        return saida;
    }

};

struct Disciplina {
   std::map<double,std::vector<double> > estagios;
   std::map<double,double> indReprovPorFalta;
   std::map<double,double> indReprovPorNota;
   std::map<double,double> indAprovados;

   //Formato do retorno: Map<Periodo,Vector(PrimEstag,SegEst,TercEst,PorcAprov,PorcReprovPorNota,PorReprovFalta)
   std::map<double, vector<double> > exibeDesempPass(int nPer) {
      std::map<double, vector<double> > retornoR;

      // Criador do Iterator + apontando pro início do mapa
	   std::map<double, std::vector<double> >::iterator it = estagios.begin();

      int ini = estagios.size() - nPer;

      for (int i = 0; i < ini; i++) {
         it++;
      }

   	while (it != estagios.end()){
      // Accessing KEY from element
		double periodo = it->first;
		// Accessing VALUE from element.
		std::vector<double> medias = it->second;

      //Vetor de informações
      std:vector<double> acresc;

      //Pondo as medias do primeiro,segundo e terceiro estagio
      acresc.push_back(medias.at(0));
      acresc.push_back(medias.at(1));
      acresc.push_back(medias.at(2));

      //Porcentagem de reprovacao e aprovacao
      acresc.push_back(indAprovados[periodo]);
      acresc.push_back(indReprovPorNota[periodo]);
      acresc.push_back(indReprovPorFalta[periodo]);

      retornoR.insert(std::pair<double,std::vector<double> >(periodo,acresc));
      acresc.clear();
		it++;
	   }

      return retornoR;
   };


   //Formato do retorno: Map<Periodo,Vector(PrimEstag,SegEst,TercEst)
   std::map<double,std::vector<double> > exibeMediasPassadas() {
      std::map<double,std::vector<double> > retornoR;

      // Criador do Iterator + apontando pro início do mapa
	   std::map<double, std::vector<double> >::iterator it = estagios.begin();

   	while (it != estagios.end()){
      // Accessing KEY from element
		double periodo = it->first;
		// Accessing VALUE from element.
		std::vector<double> medias = it->second;

      std::vector<double> mediasEst;
      mediasEst.push_back(medias.at(0));
      mediasEst.push_back(medias.at(1));
      mediasEst.push_back(medias.at(2));

      retornoR.insert(std::pair<double,std::vector<double> >(periodo,mediasEst));

		it++;
	   }

      return retornoR;
   }

   //Formato do retorno: Vector(PorcMediaAprov,PorcMediaReprovNota,PorcMediaReprovFalt)
   std::vector<double> exibeIndices() {
      int numPer = indAprovados.size();
      double somaAprov = 0;
      double somaReprovFalta = 0;
      double somaReprovNota = 0;
      double mediaAprov;
      double mediaReprovFalta;
      double mediaReprovNota;

      std::map<double, double>::iterator it = indAprovados.begin();

      //Calculo media de aprovados
      while (it != indAprovados.end()){
      // Accessing chave from element
		double periodo = it->first;
      somaAprov += indAprovados[periodo];
      somaReprovFalta += indReprovPorFalta[periodo];
      somaReprovNota += indReprovPorNota[periodo];
      it++;
      }

      mediaAprov = (somaAprov / numPer);
      mediaReprovFalta = (somaReprovFalta/numPer);
      mediaReprovNota = (somaReprovNota/numPer);

      // Pôr porcentagem de aprovados,reprovados por falta e reprovados por média nessa ordem no vetor de retorno
      std::vector<double> retorno;

      retorno.push_back(mediaAprov);
      retorno.push_back(mediaReprovNota);
      retorno.push_back(mediaReprovFalta);

      return retorno;
   }

};

int main() {
   //Dados para Testes
   Disciplina PLP;

   //Dados primeiro estagio
   std::vector<double> estagios1;
   double periodo1 = 19.1;
   estagios1.push_back(5);
   estagios1.push_back(8.3);
   estagios1.push_back(10);
   PLP.estagios.insert(std::pair<double,std::vector<double> >(periodo1,estagios1));
   PLP.indReprovPorFalta.insert(std::pair<double,double>(periodo1,20.3));
   PLP.indReprovPorNota.insert(std::pair<double,double>(periodo1,40.7));
   PLP.indAprovados.insert(std::pair<double,double>(periodo1,39));

   //Dados segundo estagio
   std::vector<double> estagios2;
   double periodo2 = 18.2;
   estagios2.push_back(3);
   estagios2.push_back(5);
   estagios2.push_back(1.5);
   PLP.estagios.insert(std::pair<double,std::vector<double> >(periodo2,estagios2));
   PLP.indReprovPorFalta.insert(std::pair<double,double>(periodo2,10.5));
   PLP.indReprovPorNota.insert(std::pair<double,double>(periodo2,19.5));
   PLP.indAprovados.insert(std::pair<double,double>(periodo2,70));

   //Dados terceiro estagio
   std::vector<double> estagios3;
   double periodo3 = 17.2;
   estagios3.push_back(3);
   estagios3.push_back(5);
   estagios3.push_back(1.5);
   PLP.estagios.insert(std::pair<double,std::vector<double> >(periodo3,estagios3));
   PLP.indReprovPorFalta.insert(std::pair<double,double>(periodo3,5));
   PLP.indReprovPorNota.insert(std::pair<double,double>(periodo3,65));
   PLP.indAprovados.insert(std::pair<double,double>(periodo3,30));

   //Testes de cada método
   //std::cout << PLP.exibeDesempPass(2);
   //std::cout << PLP.exibeMediasPassadas();
   std::cout << PLP.exibeIndices().at(0);
   std::cout << PLP.exibeIndices().at(1);
   std::cout << PLP.exibeIndices().at(2);

   return 0;
}
