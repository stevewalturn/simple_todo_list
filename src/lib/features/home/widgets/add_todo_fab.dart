import 'package:flutter/material.dart';

class AddTodoFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodoFab({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
