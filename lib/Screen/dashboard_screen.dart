import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Import the chat screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> conversations = [
    'Conversation 1',
    'Conversation 2',
    'Conversation 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(conversations[index]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(title: 'Chat')));
                });
          },
        ));
  }
}
