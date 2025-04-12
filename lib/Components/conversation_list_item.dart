// conversation_list_item.dart
import 'package:fluter_rust_message_app/Screen/chat_screen.dart';
import 'package:flutter/material.dart';

class ConversationListItem extends StatelessWidget {
  final Map<String, Object> conversation;

  const ConversationListItem({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final title = conversation['title'] as String;
    final id = conversation['id'] as String;
    final avatarUrl = conversation['avatar'] as String?;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        radius: 24,
        backgroundColor: Colors.grey[300],
      ),
      title: Text(title),
      subtitle: const Text('Some brief description or time of last message'),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(title: title, conversationId: id)));
      },
    );
  }
}
