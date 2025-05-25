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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => uploadUserAvatar(userId),
          child: AnimatedSwitcher(
            duration: Duration(microseconds: 500),
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
