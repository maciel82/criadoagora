class Questoes {
  var perguntas = [
    "primeiro planete",
    "segundo planeta",
    "terceiro planeta"
  ];

  var escolhas = [
    ["brasil", "mercurio"],
    ["venus", "dois"],
    ["sfsdf", "terra"]
  ];

  var resposta = [
    "mercurio", "venus", "terra"
  ];

  String getPerguntas(int _num){
    String pergunta = perguntas[_num];
    return pergunta;
  }

  String getEscolhasA(int _num){
    String a = escolhas[_num][0];
    return a;
  }

  String getEscolhasB(int _num){
    String b = escolhas[_num][1];
    return b;
  }

  String respostaCerta(int _num){
    String certa = resposta[_num];
    return certa;
  }

}