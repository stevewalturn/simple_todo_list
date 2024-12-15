import 'package:simple_todo_list/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:simple_todo_list/ui/bottom_sheets/todo_options/todo_options_sheet.dart';
import 'package:simple_todo_list/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:simple_todo_list/ui/dialogs/todo_form/todo_form_dialog.dart';
import 'package:simple_todo_list/features/home/home_view.dart';
import 'package:simple_todo_list/features/startup/startup_view.dart';
import 'package:simple_todo_list/services/todo_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: TodoOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: TodoFormDialog),
  ],
)
class App {}
