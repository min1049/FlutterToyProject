import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:untitled2/tests/ipconfig.dart';

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
  late String usr_name;
  List<String> message = [];
  String? exitMessage = "나가요";
  String URL = IpConfig().getURL;

  StreamSubscription? stompSubscription;
  StreamController<String> dataStreamController = StreamController<String>.broadcast();

  StompServer2({required this.room_number, required this.usr_name}){
    this.stompClient = StompClient(
        config: StompConfig.SockJS(
          url: URL,
          onConnect: onConnectCallback,
          onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        )
    );
  }

  void onConnectCallback(StompFrame frame) {
    this.subscribeToStompServer();
    this.subscribeToMessageServer();

    print('Connected to Stomp Server');
    }

  void dispose() {
    disconnectFromStompServer();
    dataStreamController.close();
  }
  void connectToStompServer() async{
    print("stomp 연결을 시도합니다.");
    await stompClient.activate();
  }
  void testSubscribeToStompServer() async {
    print("test");
    stompClient.subscribe( //stompSubscripstion 업음
      destination: '/topic/room/1234', // 구독할 토픽 이름으로 변경해야 합니다.
      callback: (StompFrame frame) {
        String? data = frame.body;
        print('Received message: $data');
        message.add(data!); // 메시지 리스트에 추가
        dataStreamController.add(data);
      }
    );
    print("request subscribe done");
  }
  //구독
  void subscribeToStompServer(){
    print("stomp 서버에 구독을 요청합니다.");
    print("room_num : {$room_number}");
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '/topic/Room/$room_number', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) async {
          if (frame.body != null) {
            print('Received message: ${frame.body}');
          }
        }
    );
    print("request subscribe done");
  }
  //app/start/ 구독
  void subscribeToMessageServer(){
    print("메세지 서버에 구독을 요청합니다.");
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '/app/Start/$room_number/$usr_name', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) async {
          if (frame.body != null) {
            print('Received message: ${frame.body}');
          }
          //message.add(data!); // 메시지 리스트에 추가
          //dataStreamController.add(data);
        }
    );
    print("request subscribe done");
  }


  void testSubscribeAppStartToStompServer() async {
    print("test");
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '/app/Start/1234', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) {
          String? data = frame.body;
          print('Received message: $data');
          message.add(data!); // 메시지 리스트에 추가
          dataStreamController.add(data);
        }
    );
    print("request subscribe done");
  }

  void subscribeAppStartToStompServer() async {
    print("room_number {$room_number}");
    stompClient.subscribe( //stompSubscripstion 업음
        destination: '/app/Start/$room_number', // 구독할 토픽 이름으로 변경해야 합니다.
        callback: (StompFrame frame) {
          String? data = frame.body;
          print('Received message: $data');
          message.add(data!); // 메시지 리스트에 추가
          dataStreamController.add(data);
        }
    );
    print("request subscribe done");
  }

  void subscribeAppToStompServer({required String destination}) async {
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

  void testSend(String message){
    stompClient.send(
      destination : '/app/Start/1234',
      body: message,
    );
  }

  void send( {required String destination} ){
    print("room number : $room_number");
    stompClient.send(
      destination : '/app/$destination/$room_number',
      body: "hi",
    );
  }
}


