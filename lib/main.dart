import 'package:assignment_comment/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:dio/dio.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CommentsApp',
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}


