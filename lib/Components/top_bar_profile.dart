import 'package:flutter/material.dart';

class TopBarProfile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String userId;
  final TextEditingController avatarUrlController;
  final void Function(String) uploadUserAvatar;
  final BuildContext context;

  const TopBarProfile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.userId,
      required this.avatarUrlController,
      required this.uploadUserAvatar,
      required this.context});

  void _changeAvatarUrl() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Avatar'),
          content: TextField(
            controller: avatarUrlController,
            autofocus: true,
            decoration:
                const InputDecoration(hintText: 'Enter User Avatar URL'),
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
                uploadUserAvatar(userId);
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
    return Row(
      children: [
        GestureDetector(
          onTap: () => _changeAvatarUrl(),
          child: AnimatedSwitcher(
            duration: Duration(microseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: CircleAvatar(
              key: ValueKey<String?>(imageUrl),
              radius: 24,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              backgroundColor: Colors.grey[300],
              child: imageUrl == null ? Icon(Icons.person, size: 24) : null,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}
