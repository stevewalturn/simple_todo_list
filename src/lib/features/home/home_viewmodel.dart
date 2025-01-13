import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../models/todo.dart';
import '../../models/todo_priority.dart';
import '../../services/todo_service.dart';
import '../../app/app.locator.dart';

class HomeViewModel extends StreamViewModel<List<Todo>> {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  @override
  Stream<List<Todo>> get stream => _todoService.todosStream;

  List<Todo> get todos => data ?? [];

  Future<void> showAddTodoDialog() async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: 'todoForm',
        title: 'Add New Todo',
        description: 'Enter todo details',
      );

      if (response?.confirmed ?? false) {
        final data = response?.data as Map<String, dynamic>;
        final todo = Todo(
          id: DateTime.now().toString(), // Generate a temporary ID
          title: data['title'] as String,
          description: data['description'] as String,
          priority: data['priority'] as TodoPriority,
          createdAt: DateTime.now(),
        );
        await _todoService.addTodo(todo);
      }
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showEditTodoDialog(Todo todo) async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: 'todoForm',
        title: 'Edit Todo',
        description: 'Update todo details',
        data: todo,
      );

      if (response?.confirmed ?? false) {
        final data = response?.data as Map<String, dynamic>;
        final updatedTodo = todo.copyWith(
          title: data['title'] as String,
          description: data['description'] as String,
          priority: data['priority'] as TodoPriority,
        );
        await _todoService.updateTodo(updatedTodo);
      }
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> toggleTodoCompletion(String id, Todo todo) async {
    try {
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      await _todoService.updateTodo(updatedTodo);
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showTodoOptions(Todo todo) async {
    try {
      final response = await _bottomSheetService.showCustomSheet(
        variant: 'todoOptions',
        title: 'Todo Options',
        description: 'Choose an action',
        data: todo,
      );

      if (response?.confirmed ?? false) {
        final data = response?.data as Map<String, dynamic>;
        switch (data['action'] as String) {
          case 'edit':
            await showEditTodoDialog(todo);
            break;
          case 'delete':
            await _todoService.deleteTodo(todo.id);
            break;
        }
      }
    } catch (e) {
      setError(e.toString());
    }
  }
}