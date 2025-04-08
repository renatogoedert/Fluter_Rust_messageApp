//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

import '../Screen/chat_screen.dart' show ChatScreen;

class ConversationList extends StatelessWidget {
  const ConversationList({super.key, required this.conversations});

  final List<Map<String, Object>> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(conversations[index]['title'] as String),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(title: 'Chat')));
            });
      },
    );
  }
}
