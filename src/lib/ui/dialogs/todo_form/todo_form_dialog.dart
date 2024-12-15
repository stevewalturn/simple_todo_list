import 'package:flutter/material.dart';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFormDialog extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const TodoFormDialog({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  TodoPriority _selectedPriority = TodoPriority.low;

  @override
  void initState() {
    super.initState();
    final todo = widget.request?.data is Todo ? widget.request?.data as Todo : null;
    _titleController = TextEditingController(text: todo?.title ?? '');
    _descriptionController = TextEditingController(text: todo?.description ?? '');
    _selectedPriority = todo?.priority ?? TodoPriority.low;
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
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.request?.title ?? 'Add Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
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
              value: _selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: TodoPriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPriority = value);
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    widget.completer?.call(DialogResponse(confirmed: false));
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Title cannot be empty')),
                      );
                      return;
                    }
                    widget.completer?.call(
                      DialogResponse(
                        confirmed: true,
                        data: {
                          'title': _titleController.text.trim(),
                          'description': _descriptionController.text.trim(),
                          'priority': _selectedPriority,
                        },
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
