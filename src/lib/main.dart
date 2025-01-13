import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/app/app_view.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const AppView());
  }, (error, stack) {
    print('Caught error: $error');
    print('Stack trace: $stack');
  });
}