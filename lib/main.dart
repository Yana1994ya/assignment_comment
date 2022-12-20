import 'package:assignment_comment/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding();
  // Prevent landscape mode, not supported for this app.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CommentsApp',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routerConfig: router,
    );

  }
}
