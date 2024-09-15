import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todos = [];

  final _myBox = Hive.box('myBox');

  void createInitData() {
    todos = [
      {
        'task': 'Buy groceries',
        'isDone': false,
        'key': UniqueKey(),
      },
      {
        'task': 'Buy books',
        'isDone': false,
        'key': UniqueKey(),
      },
      {
        'task': 'Buy stationery',
        'isDone': false,
        'key': UniqueKey(),
      },
    ];
  }

  void loadData() {
    todos = _myBox.get('todos');
  }

  void saveData() {
    _myBox.put('todos', todos);
  }
}
