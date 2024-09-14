import 'package:flutter/material.dart';

class EditDialogPage extends StatelessWidget {
  final String task;
  final TextEditingController controller;
  final int index;

  const EditDialogPage({
    super.key,
    required this.task,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter task',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Delete the task
            Navigator.of(context).pop({'delete': true});
            controller.clear(); // Clear the text input
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'task': controller.text,
              'isDone': false, // or retain the original isDone status
            });
            controller.clear(); // Clear the text input
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            controller.clear(); // Clear the text input
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
