//Code Developed By Renato Francisco Goedert

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../src/rust/lib.dart';

import '../Components/message_create.dart';
import '../Components/message_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //Controler for message text
  final TextEditingController _messageControler = TextEditingController();

  //Variable to hold the messages
  List<Map<String, Object>> messages = [];

  //Initiate State loading messages from Rust
  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  //Lead Message Function
  Future<void> _loadMessages() async {
    final rustMessages = await getMessages();
    setState(() {
      messages = rustMessages
          .map((m) => {
                'sender': m.sender,
                'text': m.text,
                'time': m.time,
                'isMe': m.isMe,
              })
          .toList();
    });
  }

  //Send Message Function
  void _sendMessage() async {
    String messageText = _messageControler.text.trim();

    if (kDebugMode) {
      print('Message text to be added: $messageText');
    }

    if (messageText.isNotEmpty) {
      DateTime timeNow = DateTime.now().toUtc();

      await addMessage(
        sender: 'Me',
        text: messageText,
        isMe: true,
      );

      //Reload messages from Rust
      _loadMessages();

      //Clear the input field
      _messageControler.clear();

      if (kDebugMode) {
        print("Message added to Rust and UI updated!");
      }
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
