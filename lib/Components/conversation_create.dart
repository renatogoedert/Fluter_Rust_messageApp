//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

class ConversationCreate extends StatelessWidget {
  const ConversationCreate(
      {super.key,
      required this.titleController,
      required this.avatarUrlController,
      required this.onSend,
      required this.context});

  final VoidCallback onSend;
  final TextEditingController titleController;
  final TextEditingController avatarUrlController;
  final BuildContext context;

  void _addNewConversation() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Conversation'),
          content: Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Enter conversation title'),
                ),
                TextField(
                  controller: avatarUrlController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Enter conversation Avatar URL'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                onSend();
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _addNewConversation,
      tooltip: 'Add Conversation',
      child: const Icon(Icons.add),
    );
  }
}
