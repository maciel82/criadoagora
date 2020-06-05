class Valida{

  int _vList;

  List list = ["primeira", "segunda", "terceira"];

  set setList(int vList){
    _vList = vList;
  }

  String get getList{
    return list[_vList];
  }
}