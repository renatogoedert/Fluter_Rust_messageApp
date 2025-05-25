// conversation_list_item.dart
import 'package:fluter_rust_message_app/Screen/chat_screen.dart';
import 'package:fluter_rust_message_app/src/rust/lib.dart';
import 'package:flutter/material.dart';

class ConversationListItem extends StatelessWidget {
  const ConversationListItem(
      {super.key,
      required this.conversation,
      required this.avatarUrlController,
      required this.toLoad,
      required this.uploadAvatar,
      required this.context});

  final Map<String, Object?> conversation;
  final void Function() toLoad;
  final void Function(String id) uploadAvatar;
  final BuildContext context;
  final TextEditingController avatarUrlController;

  void _changeAvatarUrl(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Avatar'),
          content: TextField(
            controller: avatarUrlController,
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Enter conversation Avatar URL'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                avatarUrlController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                uploadAvatar(id);
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
    final title = conversation['title'] as String;
    final id = conversation['id'] as String;
    final avatarUrl = conversation['avatarUrl'] as String?;
    final messages = conversation['messages'] as List<Message>?;

    return ListTile(
      leading: GestureDetector(
        onTap: () => _changeAvatarUrl(id),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: CircleAvatar(
            key: ValueKey<String?>(avatarUrl),
            radius: 24,
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            backgroundColor: Colors.grey[300],
            child: avatarUrl == null ? Icon(Icons.person, size: 24) : null,
          ),
        ),
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
