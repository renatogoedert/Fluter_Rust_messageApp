import 'package:fluter_rust_message_app/Components/conversation_create.dart';
import 'package:fluter_rust_message_app/Components/conversation_list.dart';
import 'package:fluter_rust_message_app/Components/top_bar_profile.dart';
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

  //Controler for Avatar Url text
  final TextEditingController _avatarUrlController = TextEditingController();

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
                'avatarUrl': c.avatarUrl,
                'messages': c.messages,
              })
          .toList();
    });
  }

  //Send Message Function
  void _sendConversation() async {
    String title = _titleController.text.trim();
    String avatarUrl = _avatarUrlController.text.trim();

    if (kDebugMode) {
      print('Conversation title to be added: $title');
      print('Conversation title to be added: $avatarUrl');
    }

    if (title.isNotEmpty) {
      await addConversation(
        filePath: await getConversationsFilePath(),
        title: title,
        avatarUrl: avatarUrl,
      );

      _titleController.clear();
      _avatarUrlController.clear();

      //Reload messages from Rust
      _loadConversarions();

      if (kDebugMode) {
        print("Conversation added to Rust and UI updated!");
      }
    }
  }

  void _deleteConversation(String id) async {
    await deleteConversation(
      filePath: await getConversationsFilePath(),
      id: id,
    );
    await _loadConversarions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: TopBarProfile(
            name: "Homer",
            imageUrl:
                "https://upload.wikimedia.org/wikipedia/commons/1/1c/Homer_British_Museum.jpg",
          ),
        ),
        body: ConversationList(
          conversations: conversations,
          onDelete: _deleteConversation,
          toLoad: _loadConversarions,
        ),
        floatingActionButton: ConversationCreate(
          titleController: _titleController,
          avatarUrlController: _avatarUrlController,
          onSend: _sendConversation,
          context: context,
        ));
  }
}
