import 'package:finance_expenses/InitialPage/GetStartedPage.dart';
import 'package:finance_expenses/Lateuse/Colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home: OnboardingPage(),
    );
  }
}
