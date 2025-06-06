import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_sample001/firebase_options.dart';
import 'package:new_sample001/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '総合アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.lightBlue[50],
      ),
      home: const HomeScreen(title: 'ホーム画面'),
    );
  }
}
