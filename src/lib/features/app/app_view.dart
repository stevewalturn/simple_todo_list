import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app_viewmodel.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.reactive(
      viewModelBuilder: () => AppViewModel(),
      builder: (context, model, child) => MaterialApp(
        title: 'Simple Todo List',
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            default:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Route not found')),
                ),
              );
          }
        },
      ),
    );
  }
}