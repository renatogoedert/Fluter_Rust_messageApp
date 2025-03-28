// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fluter_rust_message_app/Screen/chat_screen.dart'
    show ChatScreen;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluter_rust_message_app/main.dart';

void main() {
  testWidgets('ChatScreen displays initial messages and UI components',
      (WidgetTester tester) async {
    // Build the ChatScreen widget
    await tester.pumpWidget(const MaterialApp(home: ChatScreen(title: 'Chat')));

    // Verify the presence of initial messages
    expect(find.text('Hey, how are you?'), findsOneWidget);
    expect(find.text('I\'m good, thanks! How about you?'), findsOneWidget);

    // Verify the presence of the message input field and send button
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
  });

  testWidgets('Sending a new message updates the chat log',
      (WidgetTester tester) async {
    // Build the ChatScreen widget
    await tester.pumpWidget(const MaterialApp(home: ChatScreen(title: 'Chat')));

    // Enter text into the message input field
    await tester.enterText(
        find.byType(TextField), 'Hello, this is a test message.');

    // Tap the send button
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Verify the new message appears in the chat log
    expect(find.text('Hello, this is a test message.'), findsOneWidget);
  });
}
