import 'dart:async';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';
import 'package:simple_todo_list/services/firebase_service.dart';

class TodoService {
  final FirebaseService _firebaseService;

  TodoService(this._firebaseService);

  Stream<List<Todo>> get todosStream => _firebaseService.getTodosStream();

  Future<void> addTodo(Todo todo) async {
    try {
      if (todo.title.isEmpty) {
        throw Exception('Todo title cannot be empty');
      }
      await _firebaseService.addTodo(todo);
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _firebaseService.updateTodo(todo);
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _firebaseService.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: ${e.toString()}');
    }
  }

  Future<void> toggleTodoCompletion(String id, Todo todo) async {
    try {
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      await _firebaseService.updateTodo(updatedTodo);
    } catch (e) {
      throw Exception('Failed to update todo status: ${e.toString()}');
    }
  }

  List<Todo> filterTodosByPriority(List<Todo> todos, TodoPriority priority) {
    return todos.where((todo) => todo.priority == priority).toList();
  }
}
