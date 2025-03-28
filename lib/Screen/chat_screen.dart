//Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/Components/message_create.dart';
import 'package:fluter_rust_message_app/Components/message_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Controler for message text
  final TextEditingController _messageControler = TextEditingController();

  //Mock data
  List<Map<String, dynamic>> messages = [
    {
      'sender': 'Alice',
      'text': 'Hey, how are you?',
      'time': '10:30 AM',
      'isMe': false,
    },
    {
      'sender': 'Me',
      'text': 'I\'m good, thanks! How about you?',
      'time': '10:32 AM',
      'isMe': true,
    },
  ];

  //Send Message Function
  void _sendMessage() {
    //Debug Print
    if (kDebugMode) {
      print('Message text to be added: ${_messageControler.text}');
    }

    //Send Message if controller not empty
    if (_messageControler.text.isNotEmpty) {
      setState(() {
        messages.add({
          'sender': 'Me',
          'text': _messageControler.text,
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });

        //Confirmation message
        if (kDebugMode) {
          print("Message Added!");
        }

        //Needed to clean the TextField
        _messageControler.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            //Message Log
            Expanded(child: MessageList(messages: messages)),

            // //Message input Field
            Container(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 25),
                color: Colors.white,
                child: MessageCreate(
                  controller: _messageControler,
                  onSend: _sendMessage,
                ))
          ],
        ));
  }
}
