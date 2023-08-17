import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompTest{
  late dynamic stompClient;
  late dynamic channel;
  late Stream<dynamic> stream;
  late String room_number;

  StreamSubscription? stompSubscription;
  StreamController<String> dataStreamController = StreamController<String>.broadcast();

  StompTest(){
    this.stompClient = StompClient(
        config: StompConfig.SockJS(
          url: 'http://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self',
          onConnect: onConnectCallback,
          onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        )
    );
  }

  void onConnectCallback(StompFrame frame) {
    print('Connected to Stomp Server');
  }

  void dispose() {
    disconnectFromStompServer();
    dataStreamController.close();
  }

  void connectToStompServer() async {
    await stompClient.activate();
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) {
          Map<String, dynamic> obj;
          if(frame.body != null){
            obj = json.decode(frame.body!);
          }
          else{
            print("obj is null");
          }
        }
    );
  }

  void onMessageReceived(StompFrame frame) {

  }



  void disconnectFromStompServer() {
    stompSubscription?.cancel();
    stompClient.deactivate();
  }

  void send(String message){
    stompClient.send(
      destination : '/app/Start/1234',
      body: message,
    );
  }
}