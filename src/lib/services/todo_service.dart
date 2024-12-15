import 'dart:async';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';

class TodoService {
  final List<Todo> _todos = [];
  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
    _notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      _notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _notifyListeners();
    }
  }

  List<Todo> getTodosByPriority(TodoPriority priority) {
    return _todos.where((todo) => todo.priority == priority).toList();
  }

  void _notifyListeners() {
    _todoController.add(_todos);
  }

  void dispose() {
    _todoController.close();
  }
}