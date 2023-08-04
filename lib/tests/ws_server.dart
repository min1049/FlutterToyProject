import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class Server{
  final String _API_PREFIX = " ";

  Future<dynamic> testWS() async{
    // 웹소켓 채널을 생성
    // 웹 서버에 접속 시도
    final WebSocketChannel channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

    // 메세지 전송
    channel.sink.add("ㅎㅇ");
  }

}