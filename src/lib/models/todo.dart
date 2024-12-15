import 'package:simple_todo_list/models/todo_priority.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final TodoPriority priority;
  final DateTime? completedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = TodoPriority.low,
    this.completedAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    TodoPriority? priority,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}