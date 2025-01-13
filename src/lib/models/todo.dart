import 'package:simple_todo_list/models/todo_priority.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final TodoPriority priority;
  final DateTime? completedAt;
  final DateTime createdAt;

  Todo({
    String? id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = TodoPriority.low,
    this.completedAt,
    DateTime? createdAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();

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
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority.toString().split('.').last,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      priority: TodoPriority.values.firstWhere(
        (e) => e.toString().split('.').last == map['priority'],
        orElse: () => TodoPriority.low,
      ),
      completedAt: map['completedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completedAt'] as int)
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }
}
