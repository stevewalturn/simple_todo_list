import 'dart:async';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';
import 'package:simple_todo_list/services/firebase_service.dart';
import 'package:simple_todo_list/app/app.locator.dart';

class TodoService {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final _todoController = StreamController<List<Todo>>.broadcast();
  final List<Todo> _todos = [];

  Stream<List<Todo>> get todosStream => _todoController.stream;
  List<Todo> get todos => _todos;

  TodoService() {
    _initializeStream();
  }

  void _initializeStream() {
    _firebaseService.getTodosStream().listen((todos) {
      _todos.clear();
      _todos.addAll(todos);
      _notifyListeners();
    });
  }

  Future<void> addTodo(Todo todo) async {
    await _firebaseService.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _firebaseService.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _firebaseService.deleteTodo(id);
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