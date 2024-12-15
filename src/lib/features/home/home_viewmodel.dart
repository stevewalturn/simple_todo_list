import 'package:simple_todo_list/app/app.bottomsheets.dart';
import 'package:simple_todo_list/app/app.dialogs.dart';
import 'package:simple_todo_list/app/app.locator.dart';
import 'package:simple_todo_list/models/todo.dart';
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
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoForm,
    );

    if (response?.data != null) {
      final todo = response!.data as Todo;
      _todoService.addTodo(todo);
    }
  }

  Future<void> showEditTodoDialog(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoForm,
      data: todo,
    );

    if (response?.data != null) {
      final updatedTodo = response!.data as Todo;
      _todoService.updateTodo(updatedTodo);
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
  }

  Future<void> showTodoOptions(Todo todo) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoOptions,
      data: todo,
    );

    if (response?.confirmed == true) {
      switch (response?.data) {
        case 'edit':
          await showEditTodoDialog(todo);
          break;
        case 'delete':
          _todoService.deleteTodo(todo.id);
          break;
      }
    }
  }

  @override
  void onError(error) {
    // Handle any stream errors here
    super.onError(error);
  }
}
