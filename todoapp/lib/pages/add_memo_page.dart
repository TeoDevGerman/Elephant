// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/button.dart';

class AddMemo extends StatefulWidget {
  final TextEditingController controller;
  final List todos;
  final TodoDataBase db;
  const AddMemo({
    super.key,
    required this.controller,
    required this.todos,
    required this.db,
  });

  @override
  State<AddMemo> createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  void addTask() {
    setState(() {
      widget.todos.add({
        'task': widget.controller.text,
        'isDone': false,
        'key': UniqueKey(),
      });
      widget.controller.clear();
    });
    widget.db.saveData();
  }

  void addTaskAndGoBack() {
    addTask();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(name: 'Save', onPressed: addTaskAndGoBack),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
