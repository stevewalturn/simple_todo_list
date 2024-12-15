import 'package:simple_todo_list/app/app.bottomsheets.dart';
import 'package:simple_todo_list/app/app.dialogs.dart';
import 'package:simple_todo_list/app/app.locator.dart';
import 'package:simple_todo_list/models/todo.dart';
import 'package:simple_todo_list/models/todo_priority.dart';
import 'package:simple_todo_list/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
        variant: DialogType.todoForm,
        title: 'Add New Todo',
      );

      if (response != null && response.confirmed) {
        final todoData = response.data as Map<String, dynamic>;
        final todo = Todo(
          title: todoData['title'] as String,
          description: todoData['description'] as String,
          priority: todoData['priority'] as TodoPriority,
        );
        await _todoService.addTodo(todo);
      }
    } catch (e) {
      setError('Failed to add todo. Please try again.');
    }
  }

  Future<void> showEditTodoDialog(Todo todo) async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: DialogType.todoForm,
        title: 'Edit Todo',
        data: todo,
      );

      if (response != null && response.confirmed) {
        final todoData = response.data as Map<String, dynamic>;
        final updatedTodo = todo.copyWith(
          title: todoData['title'] as String?,
          description: todoData['description'] as String?,
          priority: todoData['priority'] as TodoPriority?,
        );
        await _todoService.updateTodo(updatedTodo);
      }
    } catch (e) {
      setError('Failed to update todo. Please try again.');
    }
  }

  void toggleTodoCompletion(String id) {
    try {
      _todoService.toggleTodoCompletion(id);
    } catch (e) {
      setError('Failed to update todo status. Please try again.');
    }
  }

  Future<void> showTodoOptions(Todo todo) async {
    try {
      final response = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.todoOptions,
        data: todo,
      );

      if (response?.confirmed == true) {
        final action = response!.data['action'] as String;
        switch (action) {
          case 'edit':
            await showEditTodoDialog(todo);
            break;
          case 'delete':
            await _todoService.deleteTodo(todo.id);
            break;
        }
      }
    } catch (e) {
      setError('Failed to perform action. Please try again.');
    }
  }

  @override
  void onError(error) {
    setError('An unexpected error occurred. Please try again.');
  }
}