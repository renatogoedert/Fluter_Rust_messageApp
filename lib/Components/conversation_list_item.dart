// conversation_list_item.dart
import 'package:fluter_rust_message_app/Screen/chat_screen.dart';
import 'package:fluter_rust_message_app/src/rust/lib.dart';
import 'package:flutter/material.dart';

class ConversationListItem extends StatelessWidget {
  final Map<String, Object> conversation;
  final void Function() toLoad;

  const ConversationListItem(
      {super.key, required this.conversation, required this.toLoad});

  @override
  Widget build(BuildContext context) {
    final title = conversation['title'] as String;
    final id = conversation['id'] as String;
    final avatarUrl = conversation['avatar'] as String?;
    final messages = conversation['messages'] as List<Message>?;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        radius: 24,
        backgroundColor: Colors.grey[300],
      ),
      title: Text(title),
      subtitle: Text(messages != null && messages.isNotEmpty
          ? messages.last.text
          : 'No messages yet!'),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () async {
        final shouldRefresh = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              title: title,
              conversationId: id,
            ),
          ),
        );
        if (shouldRefresh == true) {
          // Trigger an update in the DashboardScreen
          toLoad();
        }
      },
    );
  }
}
