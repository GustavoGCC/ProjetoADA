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
    string matricula;
    double CRA;
    map<const string, vector<double> > historico;

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
    map<string, Aluno> historicos;

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
   map<double,vector<double> > estagios;
   map<double,double> indReprovPorFalta;
   map<double,double> indReprovPorNota;
   map<double,double> indAprovados;
};

//Formato do retorno: Map<Periodo,<medEstagio1,medEstagio2,medEstag3,aprov,reprovNota,reprovFalta>
map<double, vector<double> > exibeDesempPass(int nPer, Disciplina d) {
    map<double,vector<double> > estagios = d.estagios;

    map<double,double> indReprovPorFalta = d.indReprovPorFalta;
    map<double,double> indReprovPorNota = d.indReprovPorFalta;
    map<double,double> indAprovados = d.indAprovados;


    map<double, vector<double> > retornoR;

    // Criador do Iterator + apontando pro início do mapa
	map<double, vector<double> >::iterator it = estagios.begin();

    int ini = estagios.size() - nPer;

    for (int i = 0; i < ini; i++) {
        it++;
    }

   	while (it != estagios.end()){
      // Accessing KEY from element
		double periodo = it->first;
		// Accessing VALUE from element.
		vector<double> medias = it->second;

      //Vetor de informações
      vector<double> acresc;

      //Pondo as medias do primeiro,segundo e terceiro estagio
      acresc.push_back(medias.at(0));
      acresc.push_back(medias.at(1));
      acresc.push_back(medias.at(2));

      //Porcentagem de reprovacao e aprovacao
      acresc.push_back(indAprovados[periodo]);
      acresc.push_back(indReprovPorNota[periodo]);
      acresc.push_back(indReprovPorFalta[periodo]);

      retornoR.insert(pair<double,vector<double> >(periodo,acresc));
      acresc.clear();
		it++;
	   }

      return retornoR;
};

    //Formato do retorno: Map<Periodo,Vector(PrimEstag,SegEst,TercEst)
map<double,vector<double> > exibeMediasPassadas(Disciplina d) {
    map<double,vector<double> > estagios = d.estagios;

    map<double,vector<double> > retornoR;

    // Criador do Iterator + apontando pro início do mapa
	map<double, vector<double> >::iterator it = estagios.begin();

   	while (it != estagios.end()){
        // Accessing KEY from element
	    double periodo = it->first;
		// Accessing VALUE from element.
		vector<double> medias = it->second;

        vector<double> mediasEst;
         mediasEst.push_back(medias.at(0));
         mediasEst.push_back(medias.at(1));
         mediasEst.push_back(medias.at(2));

         retornoR.insert(pair<double,vector<double> >(periodo,mediasEst));

	    	it++;
	     }

    return retornoR;
};

 //Formato do retorno: Vector(PorcMediaAprov,PorcMediaReprovNota,PorcMediaReprovFalt)
vector<double> exibeIndices(Disciplina d) {
    map<double,double> indReprovPorFalta = d.indReprovPorFalta;
    map<double,double> indReprovPorNota = d.indReprovPorFalta;
    map<double,double> indAprovados = d.indAprovados;
    
    int numPer = indAprovados.size();
    double somaAprov = 0;
    double somaReprovFalta = 0;
    double somaReprovNota = 0;
    double mediaAprov;
    double mediaReprovFalta;
    double mediaReprovNota;

    map<double, double>::iterator it = indAprovados.begin();

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
    vector<double> retorno;

    retorno.push_back(mediaAprov);
    retorno.push_back(mediaReprovNota);
    retorno.push_back(mediaReprovFalta);

    return retorno;
};

//Auxiliar
vector<double> calculaMediaEstagios(Disciplina d) {
    vector<double> retorno;
    map<double,vector<double> > estagios = d.estagios;
    double somaPrimEst = 0;
    double somaSegEst = 0;
    double somaTercEst = 0;
    double mediaPrimEst;
    double mediaSegEst;
    double mediaTercEst;

    //Agora, será calculada a média de cada estágio e depois comparada pra saber qual o estágio crítico  
    map<double, vector<double> >::iterator it = estagios.begin();

    //Calculo media de aprovados
    while (it != estagios.end()){
    // Accessing chave from element
	    double periodo = it->first;
        vector<double> medias = it->second;
        somaPrimEst += medias[0];
        somaSegEst += medias[1];
        somaTercEst += medias[2];
        it++;
    }

    mediaPrimEst = somaPrimEst/estagios.size();
    mediaSegEst = somaSegEst/estagios.size();
    mediaTercEst = somaTercEst/estagios.size();

    retorno.push_back(mediaPrimEst);
    retorno.push_back(mediaSegEst);
    retorno.push_back(mediaTercEst);

    return retorno;
};

vector<string> pontosCriticos(Disciplina d) {
    vector<string> retorno;

    double somaReprovFalta = 0;
    map<double,double> indReprovPorFalta = d.indReprovPorFalta;

    map<double, double>::iterator it = indReprovPorFalta.begin();

    //Calculo media de aprovados
    while (it != indReprovPorFalta.end()){
    // Accessing chave from element
	    double periodo = it->first;
        somaReprovFalta += indReprovPorFalta[periodo];
        it++;
    }

    double mediaReprovFalta = (somaReprovFalta/indReprovPorFalta.size());

    if (mediaReprovFalta >= 30) {
        string caso1 = "Indice de reprovacao por falta alto: ";
        std::ostringstream stringfalta;
        stringfalta << mediaReprovFalta;
        std::string varAsStringfalta = stringfalta.str();
        caso1 += varAsStringfalta;
        caso1 += "%";
        retorno.push_back(caso1);
    }

    vector<double> mediaEstagios = calculaMediaEstagios(d);

    //Com o resultado desse método, nós temos as médias de cada estágio, agora calcularemos o estágio crítico

    if (mediaEstagios.at(0) > mediaEstagios.at(1) && mediaEstagios.at(0) > mediaEstagios.at(2)) {
        retorno.push_back("Estagio critico: Estágio 1");
    }

    else if (mediaEstagios.at(1) > mediaEstagios.at(0) && mediaEstagios.at(1) > mediaEstagios.at(2)) {
        retorno.push_back("Estagio critico: Estágio 2");
    }

    else if (mediaEstagios.at(2) > mediaEstagios.at(1) && mediaEstagios.at(2) > mediaEstagios.at(0)) {
        retorno.push_back("Estagio critico: Estágio 1");
    }

    else if (mediaEstagios.at(0) == mediaEstagios.at(1) && mediaEstagios.at(0) > mediaEstagios.at(2)) {
        retorno.push_back("Estagios criticos: Estágio 1 e 2");
    }

    else if (mediaEstagios.at(0) == mediaEstagios.at(2) && mediaEstagios.at(0) > mediaEstagios.at(1)) {
        retorno.push_back("Estagios criticos: Estágio 1 e 3");
    }

    else if (mediaEstagios.at(1) == mediaEstagios.at(2) && mediaEstagios.at(1) > mediaEstagios.at(0)) {
        retorno.push_back("Estagios criticos: Estágio 2 e 3");
    }

    else if (mediaEstagios.at(1) == mediaEstagios.at(2) && mediaEstagios.at(1) > mediaEstagios.at(0)) {
        retorno.push_back("Todos os estágios possuem a mesma dificuldade");
    }

    return retorno;
}

int main() {
   //Dados para Testes
   Disciplina PLP;

   //Dados primeiro estagio
   vector<double> estagios1;
   double periodo1 = 19.1;
   estagios1.push_back(5);
   estagios1.push_back(8.3);
   estagios1.push_back(10);
   PLP.estagios.insert(pair<double,vector<double> >(periodo1,estagios1));
   PLP.indReprovPorFalta.insert(pair<double,double>(periodo1,40.7));
   PLP.indReprovPorNota.insert(pair<double,double>(periodo1,20.3));
   PLP.indAprovados.insert(pair<double,double>(periodo1,39));

   //Dados segundo estagio
   vector<double> estagios2;
   double periodo2 = 18.2;
   estagios2.push_back(3);
   estagios2.push_back(5);
   estagios2.push_back(1.5);
   PLP.estagios.insert(std::pair<double,vector<double> >(periodo2,estagios2));
   PLP.indReprovPorFalta.insert(pair<double,double>(periodo2,29.5));
   PLP.indReprovPorNota.insert(pair<double,double>(periodo2,0));
   PLP.indAprovados.insert(pair<double,double>(periodo2,70));

   //Dados terceiro estagio
   std::vector<double> estagios3;
   double periodo3 = 17.2;
   estagios3.push_back(3);
   estagios3.push_back(5);
   estagios3.push_back(1.5);
   PLP.estagios.insert(pair<double,vector<double> >(periodo3,estagios3));
   PLP.indReprovPorFalta.insert(pair<double,double>(periodo3,65));
   PLP.indReprovPorNota.insert(pair<double,double>(periodo3,5));
   PLP.indAprovados.insert(pair<double,double>(periodo3,30));

   //Testes de cada método
  //std::cout << exibeDesempPass(2,PLP)[18.2].at(0);
   //std::cout << PLP.exibeMediasPassadas();
   //cout << PLP.exibeIndices().at(0);
  //cout << PLP.exibeIndices().at(1);
   //cout << PLP.exibeIndices().at(2);
  // for (int i = 0; i < pontosCriticos(PLP).size(); i++) {
    //   cout << pontosCriticos(PLP).at(i);
    //   cout << "\n";
   //}

  // return 0;
}
