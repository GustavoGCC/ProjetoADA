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

   std::string exibeDesempPass(int nPer) {
      std::string retorno = "Desempenho de ";
      std::ostringstream stringn;
      stringn << nPer;
      std::string varAsStringn = stringn.str();
      retorno += varAsStringn;
      retorno += " periodo(s) atras:\n";

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

      //Medias
      retorno += "Periodo: ";
      std::ostringstream stringp;
      stringp << periodo;
      std::string varAsStringp = stringp.str();
      retorno += varAsStringp;
      retorno += "\n";
      retorno += "Media - Estágio 1: ";
      std::ostringstream string0;
      string0 << medias.at(0);
      std::string varAsString = string0.str();
      retorno += varAsString;
      retorno += "\n";
      retorno += "Media - Estágio 2: ";
      std::ostringstream string1;
      string1 << medias.at(1);
      std::string varAsString1 = string1.str();
      retorno += varAsString1;
      retorno += "\n";
      retorno += "Media - Estágio 3: ";
      std::ostringstream string2;
      string2 << medias.at(2);
      std::string varAsString2 = string2.str();
      retorno += varAsString2;
      retorno += "\n";

      //Porcentagem de reprovacao e aprovacao
      retorno += "Porcentagens de Desempenho:\n";
      retorno += "Reprovados por falta: ";
      std::ostringstream stringfalta;
      stringfalta << indReprovPorFalta[periodo];
      std::string varAsStringfalta = stringfalta.str();
      retorno += varAsStringfalta;
      retorno += "\n";

      retorno += "Reprovados por falta: ";
      std::ostringstream stringreprovNota;
      stringreprovNota << indReprovPorNota[periodo];
      std::string varAsStringreprovnota = stringreprovNota.str();
      retorno += varAsStringreprovnota;
      retorno += "\n";

      retorno += "Reprovados por falta: ";
      std::ostringstream stringAprov;
      stringAprov << indAprovados[periodo];
      std::string varAsStringAprov = stringAprov.str();
      retorno += varAsStringAprov;
      retorno += "\n";

		// Increment the Iterator to point to next entry
      retorno += "\n";
		it++;
	   }
      return retorno;
   };



   std::string exibeMediasPassadas() {
      std::string retorno = "Medias Passadas:\n";

      // Criador do Iterator + apontando pro início do mapa
	   std::map<double, std::vector<double> >::iterator it = estagios.begin();

   	while (it != estagios.end()){
      // Accessing KEY from element
		double periodo = it->first;
		// Accessing VALUE from element.
		std::vector<double> medias = it->second;

      retorno += "Periodo: ";
      std::ostringstream stringp;
      stringp << periodo;
      std::string varAsStringp = stringp.str();
      retorno += varAsStringp;
      retorno += "\n";
      retorno += "Media - Estágio 1: ";
      std::ostringstream string0;
      string0 << medias.at(0);
      std::string varAsString = string0.str();
      retorno += varAsString;
      retorno += "\n";
      retorno += "Media - Estágio 2: ";
      std::ostringstream string1;
      string1 << medias.at(1);
      std::string varAsString1 = string1.str();
      retorno += varAsString1;
      retorno += "\n";
      retorno += "Media - Estágio 3: ";
      std::ostringstream string2;
      string2 << medias.at(2);
      std::string varAsString2 = string2.str();
      retorno += varAsString2;
      retorno += "\n";
		// Increment the Iterator to point to next entry
		it++;
	   }

      retorno += "\n";
      return retorno;
   }

   std::string exibeIndices() {
      std::string retorno = "Indices medios de aprovacao e reprovacao: \n";
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
      // Accessing KEY from element
		double periodo = it->first;
      somaAprov += indAprovados[periodo];
      somaReprovFalta += indReprovPorFalta[periodo];
      somaReprovNota += indReprovPorNota[periodo];
      it++;
      }

      mediaAprov = (somaAprov / numPer);
      mediaReprovFalta = (somaReprovFalta/numPer);
      mediaReprovNota = (somaReprovNota/numPer);

      retorno += "Media de reprovados por falta:  \n";
      std::ostringstream stringfalta;
      stringfalta << mediaReprovFalta;
      std::string varAsStringfalta = stringfalta.str();
      retorno += varAsStringfalta;
      retorno += "%\n";

      retorno += "Media de reprovados por nota:  \n";
      std::ostringstream stringreprovNota;
      stringreprovNota << mediaReprovNota;
      std::string varAsStringreprovnota = stringreprovNota.str();
      retorno += varAsStringreprovnota;
      retorno += "%\n";

      retorno += "Media de Aprovados: \n";
      std::ostringstream stringAprov;
      stringAprov << mediaAprov;
      std::string varAsStringAprov = stringAprov.str();
      retorno += varAsStringAprov;
      retorno += "%\n";
      retorno += "\n";

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
   std::cout << PLP.exibeDesempPass(2);
   std::cout << PLP.exibeMediasPassadas();
   std::cout << PLP.exibeIndices();

   return 0;
}
