//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

import '../Screen/chat_screen.dart' show ChatScreen;

class ConversationList extends StatelessWidget {
  const ConversationList(
      {super.key, required this.conversations, required this.onDelete});

  final List<Map<String, Object>> conversations;
  final void Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        final title = conversation['title'] as String;
        final id = conversation['id'] as String;

        return Dismissible(
          key: Key(id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Conversation"),
                content: Text("Are you sure you want to delete '$title'?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text("Delete"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) => onDelete(id),
          child: ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    title: title,
                    conversationId: id,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
