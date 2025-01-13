import 'package:firebase_core/firebase_core.dart';
import 'package:simple_todo_list/app/app.locator.dart';
import 'package:simple_todo_list/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    try {
      setBusy(true);

      // Initialize Firebase
      await Firebase.initializeApp();

      await Future.delayed(const Duration(seconds: 1));

      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError('Failed to initialize app: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }
}
