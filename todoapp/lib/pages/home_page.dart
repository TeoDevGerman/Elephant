import 'package:flutter/material.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/pages/edit_page.dart';
import 'package:todoapp/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  final TextEditingController controller;
  final List todos;
  final TodoDataBase db;
  const HomePage({
    super.key,
    required this.controller,
    required this.todos,
    required this.db,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void taskChanged(bool? val, int index) {
    setState(() {
      widget.todos[index]['isDone'] = val;
    });
    widget.db.saveData();
  }

  void editTask(String task, int index, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return EditDialogPage(
          task: task,
          controller: controller,
          index: index,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          if (value.containsKey('delete') && value['delete'] == true) {
            widget.todos.removeAt(index);
          } else {
            widget.todos[index] = value;
          }
        });
      }
      widget.db.saveData();
    });
  }

  void dismiss(int index) {
    setState(() {
      widget.todos.removeAt(index);
      widget.db.saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = widget.todos.removeAt(oldIndex);
          widget.todos.insert(newIndex, item);
          widget.db.saveData();
        });
      },
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(widget.todos[index]['task'].toString()),
          onDismissed: (direction) {
            dismiss(index);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete),
          ),
          child: TodoTile(
            key: ValueKey(widget.todos[index]['task']),
            isDone: widget.todos[index]['isDone'],
            task: widget.todos[index]['task'],
            toggleDone: (val) {
              taskChanged(val, index);
            },
            editTask: () {
              editTask(widget.todos[index]['task'], index, widget.controller);
            },
          ),
        );
      },
    );
  }
}
