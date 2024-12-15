import 'package:flutter/material.dart';
import 'package:simple_todo_list/features/home/widgets/add_todo_fab.dart';
import 'package:simple_todo_list/features/home/widgets/todo_list.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: TodoList(
        todos: viewModel.todos,
        onToggle: viewModel.toggleTodoCompletion,
        onDelete: viewModel.toggleTodoCompletion,
        onEdit: viewModel.showEditTodoDialog,
      ),
      floatingActionButton: AddTodoFab(
        onPressed: viewModel.showAddTodoDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
