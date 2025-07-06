import 'package:flutter/material.dart';
import 'package:todo_example/data/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel data;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  const TodoItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title),
      subtitle: Text(data.desc),
      onTap: onTap,
      trailing: IconButton(
        onPressed: onDeleteTap,
        icon: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
