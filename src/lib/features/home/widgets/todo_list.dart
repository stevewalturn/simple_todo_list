import 'package:flutter/material.dart';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/features/home/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onToggle;
  final Function(Todo) onDelete;
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.list_alt,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No todos yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add a new todo',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          onToggle: () => onToggle(todo),
          onDelete: () => onDelete(todo),
          onEdit: () => onEdit(todo),
        );
      },
    );
  }
}
