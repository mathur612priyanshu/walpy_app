import 'package:flutter/material.dart';
import 'package:walpy_app/views/screen/category.dart';
import 'package:walpy_app/views/screen/search.dart';
import 'views/widgets/customAppBar.dart';
import 'views/screen/homeScreen.dart';
import 'views/screen/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Walpy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}
