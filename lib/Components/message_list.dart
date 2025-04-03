//Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/utils/date_time.dart'
    show formatISOTime;
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messages});

  final List<Map<String, dynamic>> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            return Align(
                alignment: message['isMe']
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:
                          message['isMe'] ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['text'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        formatISOTime(message['time']),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
