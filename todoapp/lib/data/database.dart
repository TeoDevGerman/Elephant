import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase{
  List todos = [];

  final _myBox = Hive.box('myBox');

  void createInitData() {
    todos = [
      {
        "task": "Buy groceries",
        "isDone": false,
      },
      {
        "task": "Buy books",
        "isDone": false,
      },
      {
        "task": "Buy stationery",
        "isDone": false,
      },
    ];
  }

  void loadData(){
    todos = _myBox.get('todos');
  }

  void saveData(){
    _myBox.put('todos', todos);
  }
}