//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

class MessageCreate extends StatelessWidget {
  const MessageCreate(
      {super.key, required this.controller, required this.onSend});

  final VoidCallback onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: 'Type a message',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        )),
        IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              onSend();
            })
      ],
    );
  }
}
