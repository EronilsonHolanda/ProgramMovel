import 'package:flutter/material.dart';
import 'package:todo_app/app_settings.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppSettings.instance,
      builder: (context, child) {
        return MaterialApp(
          title: 'Todo App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade500)
                .copyWith(
                    brightness: AppSettings.instance.isDarkMode
                        ? Brightness.dark
                        : Brightness.light),
            useMaterial3: false,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
