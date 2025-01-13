import 'package:flutter/material.dart';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function() onToggle;
  final Function() onDelete;
  final Function() onEdit;

  const TodoListItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  Color _getPriorityColor() {
    switch (todo.priority) {
      case TodoPriority.high:
        return Colors.red.shade100;
      case TodoPriority.medium:
        return Colors.orange.shade100;
      case TodoPriority.low:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Todo'),
            content: const Text('Are you sure you want to delete this todo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: Card(
        color: _getPriorityColor(),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggle(),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isCompleted ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: todo.isCompleted ? Colors.grey : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Created: ${_formatDate(todo.createdAt)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              if (todo.completedAt != null) ...[
                Text(
                  'Completed: ${_formatDate(todo.completedAt!)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onEdit,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
