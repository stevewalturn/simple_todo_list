import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:simple_todo_list/models/todo.dart';

class TodoOptionsSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest? request;

  const TodoOptionsSheet({
    Key? key,
    this.completer,
    this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract todo from request data
    final todo = request?.data as Todo?;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              completer?.call(
                SheetResponse(
                  confirmed: true,
                  data: {'action': 'edit', 'todo': todo},
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              completer?.call(
                SheetResponse(
                  confirmed: true,
                  data: {'action': 'delete', 'todo': todo},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}