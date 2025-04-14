// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they are not marked as `pub`: `load_conversations`, `save_conversations`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `fmt`, `fmt`

Future<void> addMessageToConversation(
        {required String filePath,
        required String conversationId,
        required String sender,
        required String text,
        required bool isMe}) =>
    RustLib.instance.api.crateAddMessageToConversation(
        filePath: filePath,
        conversationId: conversationId,
        sender: sender,
        text: text,
        isMe: isMe);

Future<List<Message>> getMessagesForConversation(
        {required String filePath, required String conversationId}) =>
    RustLib.instance.api.crateGetMessagesForConversation(
        filePath: filePath, conversationId: conversationId);

Future<void> addConversation(
        {required String filePath,
        required String title,
        required String avatarUrl}) =>
    RustLib.instance.api.crateAddConversation(
        filePath: filePath, title: title, avatarUrl: avatarUrl);

Future<List<Conversation>> getConversations({required String filePath}) =>
    RustLib.instance.api.crateGetConversations(filePath: filePath);

Future<void> deleteConversation(
        {required String filePath, required String id}) =>
    RustLib.instance.api.crateDeleteConversation(filePath: filePath, id: id);

class Conversation {
  final String id;
  final String title;
  final String avatarUrl;
  final List<Message> messages;

  const Conversation({
    required this.id,
    required this.title,
    required this.avatarUrl,
    required this.messages,
  });

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ avatarUrl.hashCode ^ messages.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conversation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          avatarUrl == other.avatarUrl &&
          messages == other.messages;
}

class Message {
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  const Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  int get hashCode =>
      sender.hashCode ^ text.hashCode ^ time.hashCode ^ isMe.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          sender == other.sender &&
          text == other.text &&
          time == other.time &&
          isMe == other.isMe;
}
