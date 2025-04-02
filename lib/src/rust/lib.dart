// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`

Future<void> addMessage(
        {required String sender, required String text, required bool isMe}) =>
    RustLib.instance.api
        .crateAddMessage(sender: sender, text: text, isMe: isMe);

Future<List<Message>> getMessages() => RustLib.instance.api.crateGetMessages();

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
