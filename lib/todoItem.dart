import 'package:flutter/material.dart';
import 'package:notepad/models/todos.dart';

class Todoitem extends StatelessWidget {
  final Todo todos;
  final onToDoChanged;
  final onDeleteItem;

  const Todoitem({
    super.key,
    required this.todos,
    required this.onDeleteItem,
    required this.onToDoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.black.withOpacity(0.8),
      child: ListTile(
        onTap: () {
          onToDoChanged(todos);
        },
        leading: Icon(
          todos.isDone ? Icons.radio_button_on : Icons.radio_button_off,
          color: Colors.grey,
        ),
        title: Text(
          todos.todo!,
          style: TextStyle(
              decoration: todos.isDone ? TextDecoration.lineThrough : null,
              color: Colors.grey.shade700,
              fontSize: 18),
        ),
        trailing: GestureDetector(
          onTap: () {
            onDeleteItem(todos.id);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
