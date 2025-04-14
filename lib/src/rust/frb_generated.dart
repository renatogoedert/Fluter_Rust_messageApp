// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api/simple.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'lib.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {
    await api.crateApiSimpleInitApp();
  }

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.9.0';

  @override
  int get rustContentHash => 1627568011;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'rust_lib_fluter_rust_message_app',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  Future<void> crateAddConversation(
      {required String filePath,
      required String title,
      required String avatarUrl});

  Future<void> crateAddMessageToConversation(
      {required String filePath,
      required String conversationId,
      required String sender,
      required String text,
      required bool isMe});

  Future<void> crateDeleteConversation(
      {required String filePath, required String id});

  Future<List<Conversation>> crateGetConversations({required String filePath});

  Future<List<Message>> crateGetMessagesForConversation(
      {required String filePath, required String conversationId});

  String crateApiSimpleGreet({required String name});

  Future<void> crateApiSimpleInitApp();
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  Future<void> crateAddConversation(
      {required String filePath,
      required String title,
      required String avatarUrl}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(filePath, serializer);
        sse_encode_String(title, serializer);
        sse_encode_String(avatarUrl, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 1, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateAddConversationConstMeta,
      argValues: [filePath, title, avatarUrl],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateAddConversationConstMeta => const TaskConstMeta(
        debugName: "add_conversation",
        argNames: ["filePath", "title", "avatarUrl"],
      );

  @override
  Future<void> crateAddMessageToConversation(
      {required String filePath,
      required String conversationId,
      required String sender,
      required String text,
      required bool isMe}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(filePath, serializer);
        sse_encode_String(conversationId, serializer);
        sse_encode_String(sender, serializer);
        sse_encode_String(text, serializer);
        sse_encode_bool(isMe, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 2, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateAddMessageToConversationConstMeta,
      argValues: [filePath, conversationId, sender, text, isMe],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateAddMessageToConversationConstMeta =>
      const TaskConstMeta(
        debugName: "add_message_to_conversation",
        argNames: ["filePath", "conversationId", "sender", "text", "isMe"],
      );

  @override
  Future<void> crateDeleteConversation(
      {required String filePath, required String id}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(filePath, serializer);
        sse_encode_String(id, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateDeleteConversationConstMeta,
      argValues: [filePath, id],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateDeleteConversationConstMeta => const TaskConstMeta(
        debugName: "delete_conversation",
        argNames: ["filePath", "id"],
      );

  @override
  Future<List<Conversation>> crateGetConversations({required String filePath}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(filePath, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 4, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_conversation,
        decodeErrorData: null,
      ),
      constMeta: kCrateGetConversationsConstMeta,
      argValues: [filePath],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateGetConversationsConstMeta => const TaskConstMeta(
        debugName: "get_conversations",
        argNames: ["filePath"],
      );

  @override
  Future<List<Message>> crateGetMessagesForConversation(
      {required String filePath, required String conversationId}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(filePath, serializer);
        sse_encode_String(conversationId, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 5, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_message,
        decodeErrorData: null,
      ),
      constMeta: kCrateGetMessagesForConversationConstMeta,
      argValues: [filePath, conversationId],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateGetMessagesForConversationConstMeta =>
      const TaskConstMeta(
        debugName: "get_messages_for_conversation",
        argNames: ["filePath", "conversationId"],
      );

  @override
  String crateApiSimpleGreet({required String name}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(name, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 6)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleGreetConstMeta,
      argValues: [name],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGreetConstMeta => const TaskConstMeta(
        debugName: "greet",
        argNames: ["name"],
      );

  @override
  Future<void> crateApiSimpleInitApp() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 7, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  Conversation dco_decode_conversation(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return Conversation(
      id: dco_decode_String(arr[0]),
      title: dco_decode_String(arr[1]),
      avatarUrl: dco_decode_String(arr[2]),
      messages: dco_decode_list_message(arr[3]),
    );
  }

  @protected
  List<Conversation> dco_decode_list_conversation(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_conversation).toList();
  }

  @protected
  List<Message> dco_decode_list_message(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_message).toList();
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  Message dco_decode_message(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 4)
      throw Exception('unexpected arr length: expect 4 but see ${arr.length}');
    return Message(
      sender: dco_decode_String(arr[0]),
      text: dco_decode_String(arr[1]),
      time: dco_decode_String(arr[2]),
      isMe: dco_decode_bool(arr[3]),
    );
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  Conversation sse_decode_conversation(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_id = sse_decode_String(deserializer);
    var var_title = sse_decode_String(deserializer);
    var var_avatarUrl = sse_decode_String(deserializer);
    var var_messages = sse_decode_list_message(deserializer);
    return Conversation(
        id: var_id,
        title: var_title,
        avatarUrl: var_avatarUrl,
        messages: var_messages);
  }

  @protected
  List<Conversation> sse_decode_list_conversation(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <Conversation>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_conversation(deserializer));
    }
    return ans_;
  }

  @protected
  List<Message> sse_decode_list_message(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <Message>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_message(deserializer));
    }
    return ans_;
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  Message sse_decode_message(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_sender = sse_decode_String(deserializer);
    var var_text = sse_decode_String(deserializer);
    var var_time = sse_decode_String(deserializer);
    var var_isMe = sse_decode_bool(deserializer);
    return Message(
        sender: var_sender, text: var_text, time: var_time, isMe: var_isMe);
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_conversation(Conversation self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.id, serializer);
    sse_encode_String(self.title, serializer);
    sse_encode_String(self.avatarUrl, serializer);
    sse_encode_list_message(self.messages, serializer);
  }

  @protected
  void sse_encode_list_conversation(
      List<Conversation> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_conversation(item, serializer);
    }
  }

  @protected
  void sse_encode_list_message(List<Message> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_message(item, serializer);
    }
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_message(Message self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.sender, serializer);
    sse_encode_String(self.text, serializer);
    sse_encode_String(self.time, serializer);
    sse_encode_bool(self.isMe, serializer);
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}
