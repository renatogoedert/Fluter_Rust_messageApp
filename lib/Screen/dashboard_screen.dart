import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import '../src/rust/lib.dart';

import 'chat_screen.dart'; // Import the chat screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Variable to hold the conversations
  List<Map<String, Object>> conversations = [];

  Future<String> getConversationsFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/conversations.txt';
  }

  //Initiate State loading conversations from Rust
  @override
  void initState() {
    super.initState();
    _loadConversarions();
  }

  //Lead Message Function
  Future<void> _loadConversarions() async {
    final rustConversations =
        await getConversations(filePath: await getConversationsFilePath());
    setState(() {
      conversations = rustConversations
          .map((c) => {
                'id': c.id,
                'title': c.title,
                'messages': c.messages,
              })
          .toList();
    });
  }

  void _addNewConversation() async {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Conversation'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration:
                const InputDecoration(hintText: 'Enter conversation title'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () async {
                final title = controller.text.trim();
                if (title.isNotEmpty) {
                  Navigator.of(context).pop(); // Close the dialog

                  // Add conversation using Rust
                  await addConversation(
                    filePath: await getConversationsFilePath(),
                    title: title,
                  );

                  // Reload conversations
                  await _loadConversarions();
                }
              },
            ),
          ],
        );
      },
    );
  }

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
              title: Text(conversations[index]['title'] as String),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(title: 'Chat')));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewConversation,
        tooltip: 'Add Conversation',
        child: const Icon(Icons.add),
      ),
    );
  }
}
