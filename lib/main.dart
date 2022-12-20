import 'package:assignment_comment/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Add this whenever flutter complains
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
      // Remove "Debug" banner
      debugShowCheckedModeBanner: false,
      title: 'CommentsApp',
      theme: ThemeData(
        // I like indigo!
        primarySwatch: Colors.indigo,
      ),
      // Use go_router as the project router
      routerConfig: router,
    );

  }
}
