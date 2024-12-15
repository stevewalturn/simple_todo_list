import 'package:flutter/material.dart';
import 'package:simple_todo_list/models/todo.dart';

class TodoFormDialog extends StatefulWidget {
  final Todo? todo;

  const TodoFormDialog({
    this.todo,
    super.key,
  });

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late TodoPriority _priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title);
    _descriptionController =
        TextEditingController(text: widget.todo?.description);
    _priority = widget.todo?.priority ?? TodoPriority.low;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.todo == null ? 'Add Todo' : 'Edit Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TodoPriority>(
              value: _priority,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: TodoPriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.trim().isEmpty) {
                      return;
                    }
                    final todo = Todo(
                      id: widget.todo?.id ?? DateTime.now().toString(),
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      isCompleted: widget.todo?.isCompleted ?? false,
                      createdAt: widget.todo?.createdAt ?? DateTime.now(),
                      completedAt: widget.todo?.completedAt,
                      priority: _priority,
                    );
                    Navigator.pop(context, todo);
                  },
                  child: Text(widget.todo == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
