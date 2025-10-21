import 'package:flutter/material.dart';
import 'package:myflow_mini_companion_app/config/dependencies.dart';
import 'package:myflow_mini_companion_app/config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dependencies(
      child: MaterialApp(
        title: 'MyFlow Mini Companion',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color.fromARGB(255, 88, 238, 255)),
        initialRoute: AppRoutes.home,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}

