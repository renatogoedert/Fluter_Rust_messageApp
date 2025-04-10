// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fluter_rust_message_app/Screen/chat_screen.dart'
    show ChatScreen;
import 'package:fluter_rust_message_app/Screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:fluter_rust_message_app/main.dart';

void main() {
  testWidgets('DashScreen displays initial UI components',
      (WidgetTester tester) async {
    // Build the DashboardScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: DashboardScreen(
      title: 'Dashboad',
    )));

    // Verify the presence of the Add button
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('DashScreen opens Dialog', (WidgetTester tester) async {
    // Build the DashboardScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: DashboardScreen(
      title: 'Dashboad',
    )));

    // Press the Add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the presence of Create and Cancel button
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Cancel buttom closes Dialog', (WidgetTester tester) async {
    // Build the DashboardScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: DashboardScreen(
      title: 'Dashboad',
    )));

    //Press Add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    //Press Cancel Buttom
    await tester.tap(find.text('Cancel'));
    await tester.pump();

    // Verify the Close pop Dialog
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Create'), findsNothing);
    expect(find.text('Cancel'), findsNothing);
  });

  testWidgets('Create buttom creates conversation',
      (WidgetTester tester) async {
    // Build the DashboardScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: DashboardScreen(
      title: 'Dashboard',
    )));

    //Press Add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    //Press Create Buttom
    await tester.enterText(find.byType(TextField), 'Test');
    expect(find.text('Test'), findsOneWidget);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    // Verify the Conversation creation
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Create'), findsNothing);
    expect(find.text('Cancel'), findsNothing);
    expect(find.text('Dashboard'), findsOneWidget);
  });

  testWidgets('ChatScreen displays initial UI components',
      (WidgetTester tester) async {
    // Build the ChatScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: ChatScreen(
      title: 'Chat',
      conversationId: "2",
    )));

    // Verify the presence of the message input field and send button
    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Sending a new message updates the chat log',
      (WidgetTester tester) async {
    // Build the ChatScreen widget
    await tester.pumpWidget(const MaterialApp(
        home: ChatScreen(
      title: 'Chat',
      conversationId: '2',
    )));

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
