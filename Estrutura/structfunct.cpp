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
const vector<string> split(string frase, const char &c);

struct Aluno
{
    string matricula;
    double CRA;
    map<const string, vector<double> > historico;

    void cadastraDisciplina(string disciplina, double nota)
    {
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

    void cadastraMatricula(string mat)
    {
        matricula = mat;
    }
};

struct Alunos
{
    map<string, Aluno> historicos;

    void cadastraHistorico(string linha)
    {
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

    const vector<string> split(string frase, const char &c)
    {
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
};

struct Disciplina
{
    string nome;
    map<double, vector<double> > estagios;
    map<double, double> indReprovPorFalta;
    map<double, double> indReprovPorNota;
    map<double, double> indAprovados;
};

//Formato do retorno: Map<Periodo,<medEstagio1,medEstagio2,medEstag3,aprov,reprovNota,reprovFalta>
void exibeDesempPass(int nPer, Disciplina d){

    map<double, vector<double> > estagios = d.estagios;

    if (nPer <= 0 || nPer > estagios.size()) {
        cout << "numero de periodos invalido\n";
        return;
    }


    map<double, double> indReprovPorFalta = d.indReprovPorFalta;
    map<double, double> indReprovPorNota = d.indReprovPorFalta;
    map<double, double> indAprovados = d.indAprovados;

    map<double, vector<double> > retornoR;

    // Criador do Iterator + apontando pro início do mapa
    map<double, vector<double> >::iterator it = estagios.begin();

    int ini = estagios.size() - nPer;

    for (int i = 0; i < ini; i++)
    {
        it++;
    }

    while (it != estagios.end())
    {
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

        retornoR.insert(pair<double, vector<double> >(periodo, acresc));
        acresc.clear();
        it++;
    }

    map<double,vector<double> >::iterator ite = retornoR.begin();

    while (ite != retornoR.end()) {
        double period = ite->first;
        vector<double> infos = ite->second;
        cout << "periodo: " << period << "\n";
        cout << "media no primeiro estagio: " << infos.at(0) << "\n";
        cout << "media no segundo estagio: " << infos.at(1) << "\n";
        cout << "media no terceiro estagio: " << infos.at(2) << "\n";
        cout << "porcent de aprovacao por nota: " << infos.at(3) << "%\n" ;
        cout << "porcent de reprovacao por nota: " << infos.at(4) << "%\n";
        cout << "porcent de reprovacao por falta: " << infos.at(5) << "%\n";
        cout << "\n";
        ite++;
    }
};

void exibeMediasPassadas(Disciplina d){
    map<double, vector<double> > estagios = d.estagios;

    map<double, vector<double> > retornoR;

    // Criador do Iterator + apontando pro início do mapa
    map<double, vector<double> >::iterator it = estagios.begin();

    while (it != estagios.end())
    {
        // Accessing KEY from element
        double periodo = it->first;
        // Accessing VALUE from element.
        vector<double> medias = it->second;

        vector<double> mediasEst;
        mediasEst.push_back(medias.at(0));
        mediasEst.push_back(medias.at(1));
        mediasEst.push_back(medias.at(2));

        retornoR.insert(pair<double, vector<double> >(periodo, mediasEst));

        it++;
    }
    
    map<double,vector<double> >::iterator ite = retornoR.begin();

    while (ite != retornoR.end()) {
        double period = ite->first;
        vector<double> infos = ite->second;
        cout << "periodo: " << period << "\n";
        cout << "media no primeiro estagio: " << infos.at(0) << "\n";
        cout << "media no segundo estagio: " << infos.at(1) << "\n";
        cout << "media no terceiro estagio: " << infos.at(2) << "\n";
        cout << "\n";
        ite++;
    }
};

void exibeIndices(Disciplina d)
{
    map<double, double> indReprovPorFalta = d.indReprovPorFalta;
    map<double, double> indReprovPorNota = d.indReprovPorNota;
    map<double, double> indAprovados = d.indAprovados;

    int numPer = indAprovados.size();
    double somaAprov = 0;
    double somaReprovFalta = 0;
    double somaReprovNota = 0;
    double mediaAprov;
    double mediaReprovFalta;
    double mediaReprovNota;

    map<double, double>::iterator it = indAprovados.begin();

    //Calculo media de aprovados
    while (it != indAprovados.end())
    {
        // Accessing chave from element
        double periodo = it->first;
        somaAprov += indAprovados[periodo];
        somaReprovFalta += indReprovPorFalta[periodo];
        somaReprovNota += indReprovPorNota[periodo];
        it++;
    }

    mediaAprov = (somaAprov / numPer);
    mediaReprovFalta = (somaReprovFalta / numPer);
    mediaReprovNota = (somaReprovNota / numPer);

    // Pôr porcentagem de aprovados,reprovados por falta e reprovados por média nessa ordem no vetor de retorno
    vector<double> retorno;

    retorno.push_back(mediaAprov);
    retorno.push_back(mediaReprovNota);
    retorno.push_back(mediaReprovFalta);

    cout << "porcentagens de aprovacao e reprovacao da disciplina durante todos os periodos registrados: \n";
    cout << "porcentagem de aprovacao: " << retorno.at(0) << " %\n";
    cout << "porcentagem de reprovacao por nota: " << retorno.at(1) << " %\n";
    cout << "porcentagem de reprovacao por falta: " << retorno.at(2) << " %\n";
    cout << "\n";

};

//Auxiliar
vector<double> calculaMediaEstagios(Disciplina d)
{
    vector<double> retorno;
    map<double, vector<double> > estagios = d.estagios;
    double somaPrimEst = 0;
    double somaSegEst = 0;
    double somaTercEst = 0;
    double mediaPrimEst;
    double mediaSegEst;
    double mediaTercEst;

    //Agora, será calculada a média de cada estágio e depois comparada pra saber qual o estágio crítico
    map<double, vector<double> >::iterator it = estagios.begin();

    //Calculo media de aprovados
    while (it != estagios.end())
    {
        // Accessing chave from element
        double periodo = it->first;
        vector<double> medias = it->second;
        somaPrimEst += medias[0];
        somaSegEst += medias[1];
        somaTercEst += medias[2];
        it++;
    }

    mediaPrimEst = somaPrimEst / estagios.size();
    mediaSegEst = somaSegEst / estagios.size();
    mediaTercEst = somaTercEst / estagios.size();

    retorno.push_back(mediaPrimEst);
    retorno.push_back(mediaSegEst);
    retorno.push_back(mediaTercEst);

    return retorno;
};
// Pontos criticos
void pontosCriticos(Disciplina d)
{
    vector<string> retorno;

    double somaReprovFalta = 0;
    map<double, double> indReprovPorFalta = d.indReprovPorFalta;

    map<double, double>::iterator it = indReprovPorFalta.begin();

    //Calculo media de aprovados
    while (it != indReprovPorFalta.end())
    {
        // Accessing chave from element
        double periodo = it->first;
        somaReprovFalta += indReprovPorFalta[periodo];
        it++;
    }

    double mediaReprovFalta = (somaReprovFalta / indReprovPorFalta.size());

    if (mediaReprovFalta >= 30)
    {
        string caso1 = "indice de reprovacao por falta alto: ";
        std::ostringstream stringfalta;
        stringfalta << mediaReprovFalta;
        std::string varAsStringfalta = stringfalta.str();
        caso1 += varAsStringfalta;
        caso1 += "%";
        retorno.push_back(caso1);
    }

    vector<double> mediaEstagios = calculaMediaEstagios(d);

    //Com o resultado desse método, nós temos as médias de cada estágio, agora calcularemos o estágio crítico

    if (mediaEstagios.at(0) > mediaEstagios.at(1) && mediaEstagios.at(0) > mediaEstagios.at(2))
    {
        retorno.push_back("estagio critico: estagio 1");
    }

    else if (mediaEstagios.at(1) > mediaEstagios.at(0) && mediaEstagios.at(1) > mediaEstagios.at(2))
    {
        retorno.push_back("estagio critico: estagio 2");
    }

    else if (mediaEstagios.at(2) > mediaEstagios.at(1) && mediaEstagios.at(2) > mediaEstagios.at(0))
    {
        retorno.push_back("estagio critico: Estagio 1");
    }

    else if (mediaEstagios.at(0) == mediaEstagios.at(1) && mediaEstagios.at(0) > mediaEstagios.at(2))
    {
        retorno.push_back("estagios criticos: estágios 1 e 2");
    }

    else if (mediaEstagios.at(0) == mediaEstagios.at(2) && mediaEstagios.at(0) > mediaEstagios.at(1))
    {
        retorno.push_back("estagios criticos: estagios 1 e 3");
    }

    else if (mediaEstagios.at(1) == mediaEstagios.at(2) && mediaEstagios.at(1) > mediaEstagios.at(0))
    {
        retorno.push_back("estagios criticos: estagios 2 e 3");
    }

    else if (mediaEstagios.at(1) == mediaEstagios.at(2) && mediaEstagios.at(1) > mediaEstagios.at(0))
    {
        retorno.push_back("todos os estagios possuem a mesma dificuldade");
    }

    for (int i = 0; i < retorno.size(); i++) {
        cout << retorno.at(i) << "\n";
    }
}

//Imprime uma lista de alunos com CRA dentro do intervalo passsado
void agruparAlunos(Alunos a, double iniInter, double fimInter)
{
    if (iniInter > fimInter) {
        cout << "intervalo invalido\n";
    }

    map<string, Aluno> historico = a.historicos;

    map<string, Aluno>::iterator it = historico.begin();

    while (it != historico.end())
    {
        double cra = it->second.CRA;

        if ((cra >= iniInter) && (cra <= fimInter))
        {
            cout << "- " << it->first << "\n";
        }

        it++;
    }
}

//Imprime o desempenho sobre as disciplinas que são pré-requisitos
void desempPreRequisitos(vector<string> disc, Alunos a)
{

    map<string, Aluno> alunos = a.historicos;
    map<string, Aluno>::iterator it = alunos.begin();

    for (int i = 0; i < disc.size(); i++)
    {
        cout << "---- " << disc[i] << "----\n";
        int acimaDeSete;
        int entreCincoeSete;

        while (it != alunos.end())
        {
            Aluno aluno = it->second;
            map<const string, vector<double> > historico = aluno.historico;
            vector<double> notas = historico[disc[i]];
            double media = notas[notas.size() - 1];
            if (media >= 7.0)
            {
                acimaDeSete++;
            }
            else
            {
                entreCincoeSete++;
            }
            it++;
        }

        cout << acimaDeSete << "alunos pagaram com média acima de 7,0\n"
             << entreCincoeSete << "alunos pagaram com média abaixo de 7,0 (Finalistas)\n\n";
    }
}

//Imprime o desempenho sobre as disciplinas desejáveis pelo professor
void desempDiscDesejaveis(vector<string> disc, Alunos a)
{
    map<string, Aluno> alunos = a.historicos;
    map<string, Aluno>::iterator it = alunos.begin();

    for (int i = 0; i < disc.size(); i++)
    {
        cout << "---- " << disc[i] << "----\n";
        int acimaDeSete;
        int entreCincoeSete;
        int naoPagaram;

        while (it != alunos.end())
        {
            Aluno aluno = it->second;
            map<const string, vector<double> > historico = aluno.historico;
            if (historico.find(disc[i]) != historico.end())
            {
                vector<double> notas = historico[disc[i]];
                double media = notas[notas.size() - 1];
                if (media >= 7.0)
                {
                    acimaDeSete++;
                }
                else
                {
                    entreCincoeSete++;
                }
            }
            else
            {
                naoPagaram++;
            }
            it++;
        }

        cout << acimaDeSete << "alunos pagaram com media acima de 7,0\n"
             << entreCincoeSete << "alunos pagaram com media abaixo de 7,0 (finalistas) ou reprovaram\n";

        cout << naoPagaram << "alunos nao pagaram esta disciplina!\n\n";
    }
}

//Imprime uma lista de alunos que possuem ao menos n reprovações
void repetentesComuns(int n, Alunos a) {
    if (n < 0) {
        cout << "numero de reprovacoes invalido\n";
        return;
    }

    map<string, Aluno> alunos = a.historicos;
    map<string, Aluno>::iterator it = alunos.begin();

    cout << "\nos seguintes alunos possuem " << n << " ou mais reprovações no curriculo:\n";

    while (it != alunos.end())
    {
        int reprovacoes;
        Aluno aluno = it->second;
        map<const string, vector<double> > historico = aluno.historico;
        map<const string, vector<double> >::iterator itDisc = historico.begin();
        while (itDisc != historico.end())
        {
            vector<double> notas = itDisc->second;
            for (int k = 0; k < notas.size(); k++)
            {
                if (notas[k] < 5)
                {
                    reprovacoes++;
                }
            }
            itDisc++;
        }
        if (reprovacoes >= n)
        {
            cout << "- " << aluno.matricula << "\n";
        }
        it++;
    }
}

void repetentesDisc(Alunos a, string disciplina){
    map<string, Aluno> alunos = a.historicos;
    map<string, Aluno>::iterator it = alunos.begin();

    cout << "\nos seguintes alunos ja reprovaram esta disciplina:\n";

    while (it != alunos.end())
    {
        Aluno aluno = it->second;
        map<const string, vector<double> > historico = aluno.historico;
        if (historico.find(disciplina) != historico.end()){
            cout << "- " << aluno.matricula << "\n";
        }
        it++;
    }
}

int main()
{
    //Dados para Testes
    Disciplina PLP;

    //Dados primeiro estagio
    vector<double> estagios1;
    double periodo1 = 19.1;
    estagios1.push_back(5);
    estagios1.push_back(8.3);
    estagios1.push_back(10);
    PLP.estagios.insert(pair<double, vector<double> >(periodo1, estagios1));
    PLP.indReprovPorFalta.insert(pair<double, double>(periodo1, 40.7));
    PLP.indReprovPorNota.insert(pair<double, double>(periodo1, 20.3));
    PLP.indAprovados.insert(pair<double, double>(periodo1, 39));

    //Dados segundo estagio
    vector<double> estagios2;
    double periodo2 = 18.2;
    estagios2.push_back(3);
    estagios2.push_back(5);
    estagios2.push_back(1.5);
    PLP.estagios.insert(std::pair<double, vector<double> >(periodo2, estagios2));
    PLP.indReprovPorFalta.insert(pair<double, double>(periodo2, 29.5));
    PLP.indReprovPorNota.insert(pair<double, double>(periodo2, 0));
    PLP.indAprovados.insert(pair<double, double>(periodo2, 70));

    //Dados terceiro estagio
    std::vector<double> estagios3;
    double periodo3 = 17.2;
    estagios3.push_back(3);
    estagios3.push_back(5);
    estagios3.push_back(1.5);
    PLP.estagios.insert(pair<double, vector<double> >(periodo3, estagios3));
    PLP.indReprovPorFalta.insert(pair<double, double>(periodo3, 65));
    PLP.indReprovPorNota.insert(pair<double, double>(periodo3, 5));
    PLP.indAprovados.insert(pair<double, double>(periodo3, 30));

    exibeDesempPass(2,PLP);
    exibeIndices(PLP);
    pontosCriticos(PLP);

    return 0;
}
