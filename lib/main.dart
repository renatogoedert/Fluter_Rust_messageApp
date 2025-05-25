// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// //Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/Screen/auth_screen.dart'
    show AuthScreen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluter_rust_message_app/Provider/auth_provider.dart';
import 'package:fluter_rust_message_app/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RustLib.init();

  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthScreen(),
    );
  }
}
