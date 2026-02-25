import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- IMPORT DOTENV
import 'package:readease/screens/main_wrapper.dart';
import 'package:readease/utils/constants.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before loading the env file
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file!
  await dotenv.load(fileName: ".env");

  runApp(const DyslexiaApp());
}

class DyslexiaApp extends StatelessWidget {
  const DyslexiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buddy Reading',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textMain),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.textMain),
          bodyLarge: TextStyle(color: AppColors.textMain),
        ),
      ),
      home: const MainWrapper(),
    );
  }
}