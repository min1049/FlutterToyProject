import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WSServer{
  late WebSocketChannel channel;
  Stream<dynamic>? stream;

  WSServer() {
    // WebSocket 서버 URL을 'ws://your-websocket-server-url'로 바꿔주세요.
    channel = IOWebSocketChannel.connect('wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self');
    stream = channel.stream.asBroadcastStream();
  }
  Future<dynamic> testWS() async{
    channel.sink.add("ㅎㅇ");
  }
}