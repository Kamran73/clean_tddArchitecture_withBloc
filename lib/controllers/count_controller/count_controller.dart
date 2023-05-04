import 'package:flutter/cupertino.dart';

class CountController with ChangeNotifier{
  int _count = 0;
  int get getCount => _count;

  List<int> _list = [1,2,3,4,5,6,7,8,9,0,1,1,2,2,3,4,5,6,7];

  List<int> get getList => _list;

  void updateValue(){
    _count ++;
    notifyListeners();
  }

  void addValue({required int value}){
    _list.add(value);
    notifyListeners();
  }

  void removeAt({required index}){
    _list.removeAt(index);
    notifyListeners();
  }
}