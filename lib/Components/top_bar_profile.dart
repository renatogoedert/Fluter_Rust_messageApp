import 'package:flutter/material.dart';

class TopBarProfile extends StatelessWidget {
  final String imageUrl;
  final String name;
  const TopBarProfile({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          child: Text('A'),
        ),
        SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}
