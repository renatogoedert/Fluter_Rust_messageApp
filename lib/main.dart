import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatScreen(title: "Chat"),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageControler = TextEditingController();

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
    // Additional messages can be added here
  ];

  void _sendMessage() {
    if (kDebugMode) {
      print('send message function run');
      print('Message text to be added: ${_messageControler.text}');
    }
    if (_messageControler.text.isNotEmpty) {
      setState(() {
        messages.add({
          'sender': 'Me',
          'text': _messageControler.text,
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });
        if (kDebugMode) {
          print("Message Added!");
        }
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
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
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
                              color: message['isMe']
                                  ? Colors.blue[100]
                                  : Colors.grey[300],
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
                                message['time'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ));
                  }),
            )),

            // //Message input Field
            Container(
              padding:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 25),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _messageControler,
                    decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )),
                  IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (kDebugMode) {
                          print('send cliked!');
                        }
                        _sendMessage();
                      })
                ],
              ),
            )
          ],
        ));
  }
}
