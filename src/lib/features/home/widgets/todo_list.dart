import 'package:flutter/material.dart';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/features/home/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(Todo) onEdit;

  const TodoList({
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet. Add one by tapping the + button!',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          onToggle: () => onToggle(todo.id),
          onDelete: () => onDelete(todo.id),
          onEdit: () => onEdit(todo),
        );
      },
    );
  }
}
