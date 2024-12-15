import 'dart:async';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';

class TodoService {
  final List<Todo> _todos = [];
  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => List.unmodifiable(_todos);

  Future<void> addTodo(Todo todo) async {
    try {
      if (todo.title.isEmpty) {
        throw Exception('Todo title cannot be empty');
      }
      _todos.add(todo);
      _notifyListeners();
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index == -1) {
        throw Exception('Todo not found');
      }
      _todos[index] = todo;
      _notifyListeners();
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _todos.removeWhere((todo) => todo.id == id);
      _notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete todo: ${e.toString()}');
    }
  }

  Future<void> toggleTodoCompletion(String id) async {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index == -1) {
        throw Exception('Todo not found');
      }
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _notifyListeners();
    } catch (e) {
      throw Exception('Failed to update todo status: ${e.toString()}');
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
