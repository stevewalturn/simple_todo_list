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
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.hasError
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        viewModel.modelError.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: viewModel.initialise,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : TodoList(
                  todos: viewModel.todos,
                  onToggle: (todo) =>
                      viewModel.toggleTodoCompletion(todo.id, todo),
                  onDelete: (todo) => viewModel.showTodoOptions(todo),
                  onEdit: (todo) => viewModel.showTodoOptions(todo),
                ),
      floatingActionButton: AddTodoFab(
        onPressed: viewModel.showAddTodoDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialise();
}
