import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/providers/theme_provider.dart';
import 'package:flutter_todo_provider/providers/todo_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChangeProvider>(
          create: (_) => ThemeChangeProvider(),
        ),
        ChangeNotifierProvider<ToDoProvider>(
          create: (_) => ToDoProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeChangeProvider>(context).getTheme,
    );
  }
}
