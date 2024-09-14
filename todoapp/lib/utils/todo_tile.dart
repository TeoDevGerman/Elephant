import 'package:flutter/material.dart';
import 'package:todoapp/utils/button.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.isDone,
    required this.task,
    required this.toggleDone,
    required this.editTask,
  });

  final bool isDone;
  final String task;
  final Function(bool?)? toggleDone;
  final VoidCallback editTask;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: isDone,
              onChanged: toggleDone,
            ),
            Text(
              task,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: CustomButton(name: 'Edit', onPressed: editTask),
            ),
          ],
        ),
      ),
    );
  }
}
