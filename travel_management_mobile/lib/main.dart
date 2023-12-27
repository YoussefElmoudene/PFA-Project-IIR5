import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:travel_management_mobile/routes/app_routes.dart';
import 'package:travel_management_mobile/theme/theme_helper.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Pfa',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
