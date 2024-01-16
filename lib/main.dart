import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp1/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note_app',
      theme: ThemeData(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
