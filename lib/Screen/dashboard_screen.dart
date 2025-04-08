import 'package:fluter_rust_message_app/Components/conversation_create.dart';
import 'package:fluter_rust_message_app/Components/conversation_list.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import '../src/rust/lib.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Controler for title text
  final TextEditingController _titleController = TextEditingController();

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

  //Handles the dispose of the controller
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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

  //Send Message Function
  void _sendConversation() async {
    String title = _titleController.text.trim();

    if (kDebugMode) {
      print('Conversation title to be added: $title');
    }

    if (title.isNotEmpty) {
      await addConversation(
        filePath: await getConversationsFilePath(),
        title: title,
      );

      _titleController.clear();

      //Reload messages from Rust
      _loadConversarions();

      if (kDebugMode) {
        print("Conversation added to Rust and UI updated!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ConversationList(conversations: conversations),
        floatingActionButton: ConversationCreate(
          controller: _titleController,
          onSend: _sendConversation,
          context: context,
        ));
  }
}
