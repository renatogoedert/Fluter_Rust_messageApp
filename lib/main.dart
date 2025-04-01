// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// //Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/Screen/chat_screen.dart'
    show ChatScreen;
import 'package:flutter/material.dart';
import 'package:fluter_rust_message_app/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RustLib.init();

  runApp(const MyApp());
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
      home: const ChatScreen(title: "Chat"),
    );
  }
}
