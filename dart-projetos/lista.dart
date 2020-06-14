import 'dart:io';

main(){
  List<List<String>> list = List();
  
  list = [["df", "sdf"],["sdf", "sdff"]];
  
  list.add(["soi","tere"]);
  print("digite sua pergunta");
  String questoes = stdin.readLineSync();
  list.add([questoes]);
  print("\n $list");
  exit(1);

}