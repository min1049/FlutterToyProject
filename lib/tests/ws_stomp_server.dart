import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

/*
void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/topic/test/subscription',
    callback: (frame) {
      List<dynamic>? result = json.decode(frame.body!);
      print(result);
    },
  );

  Timer.periodic(Duration(seconds: 10), (_) {
    stompClient.send(
      destination: '/app/test/endpoints',
      body: json.encode({'a': 123}),
    );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://localhost:8080/ws',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);

void main() {
  stompClient.activate();
}

 */
/*
class StompServer{
  late dynamic stompClient;
  StompServer(){
    this.stompClient = StompClient(
        config: StompConfig(
          url: 'ws://10.14.4.153:8080',
          onConnect: onConnect,
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
          stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
          webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
        ),
    );
  }
}


 */
class StompServer2{
  late dynamic stompClient;
  late dynamic channel;
  late dynamic stream;
  late String room_number;
  List<String> message = [];

  StreamSubscription? stompSubscription;
  StreamController<String> dataStreamController = StreamController<String>.broadcast();

  StompServer2({required this.room_number}){
    this.stompClient = StompClient(
        config: StompConfig.SockJS(
          url: 'http://10.14.4.103:8080/room',
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
  void connectToStompServer() async{
    await stompClient.activate();
  }
  void subscribeToStompServer() async {
    print("room_number {$room_number}");
    stompClient.subscribe( //stompSubscripstion 업음
      destination: '/topic/room/$room_number', // 구독할 토픽 이름으로 변경해야 합니다.
      callback: (StompFrame frame) {
        String? data = frame.body;
        print('Received message: $data');
        message.add(data!); // 메시지 리스트에 추가
        dataStreamController.add(data);
      }
    );
    print("request subscribe done");
  }

  void subscribeAppToStompServer(String destination) async {
    print("room_number {$room_number}");
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '/app/$destination/$room_number', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) {
          String? data = frame.body;
          print('Received message: $data');
          message.add(data!); // 메시지 리스트에 추가
          dataStreamController.add(data);
        }
    );
    print("request subscribe done");
  }

  List<String> getMessage(){
    return message;
  }

  void onMessageReceived(StompFrame frame) {

  }

  void disconnectFromStompServer() {
    stompClient.deactivate();
    print("disconnected StompServer");
  }

  void cancelFromStompServer(){
    stompSubscription?.cancel();
    print("canceled StompServer");
  }

  void send(String message){
    stompClient.send(
      destination : '/app/Start/1234',
      body: message,
    );
  }

}

