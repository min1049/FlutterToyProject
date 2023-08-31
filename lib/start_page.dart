import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/Design/screen_start.dart';
import 'package:untitled2/test_stomp.dart';
import 'package:untitled2/tests/dio_server.dart';
import 'package:untitled2/tests/json_parse.dart';
import 'package:untitled2/tests/ws_stomp_server.dart';

import 'make_room2.dart';

class SelectPlayerState extends StatefulWidget {
  @override
  _SelectPlayerState createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayerState> {
  var usr_name;
  String? room_id;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text("닉네임 : $usr_name"),
              Text("방번호: $room_id"),
              Text("닉네임",
              style: TextStyle(fontFamily: "cafe",fontSize: 32,fontWeight: FontWeight.bold),),
              Text("닉네임",
              style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
              Container(
                  child: TextField(
                decoration: InputDecoration(
                  labelText: '닉네임을 입력하세요',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    usr_name = value;
                  });
                },
              )),
              Text("방번호"),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '방 번호를 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      room_id = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StartPage(usrname: "Player1")));
                      },
                      child: Text("테스트 페이지")),
                  ElevatedButton(
                      onPressed: () async {
                        List<dynamic> responseName =
                            await server.postGetName("1235");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DesignedStartPage(
                                    usr_names: responseName,
                                    room_number: room_id,
                                    round: "1")));
                      },
                      child: Text("게임 테스트")),
                ],
              ),
            ],
          ),
          Container()
        ],
      ),
    )));
  }
}

class StartPage extends StatefulWidget {
  late String usrname;

  //WSServer ws = WSServer();
  //StompServer st = StompServer();
  StartPage({Key? key, required this.usrname}) : super(key: key);

  //StartPage.SelectPlayer({Key? key, required this.usrname}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StartPageState(usr_name: usrname);
  }
}

class StartPageState extends State<StartPage> {
  late String usr_name;
  String room_num = "1234";

  StartPageState({required this.usr_name});

  HttpServer server = HttpServer(); // http 전용 서버 생성

  late Response getItem;

  //stomp 전용 서버 생성
  String message = '';

  @override
  Widget build(BuildContext context) {
    StompServer2 st2 = StompServer2(room_number: room_num);
    return MaterialApp(
        home: Scaffold(
            body: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("현재 플레이어 : $usr_name"),
          Container(
            child: Text("시작화면"),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                usr_name = value;
              },
            ),
            width: 150,
          ),
          Container(
              child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (usr_name == "") {
                    showToast();
                  } else {
                    //StompServer2 st2 = StompServer2(room_number: room_num);
                    server.postCreateRoom(room_num, usr_name);
                    final List<String> response =
                        await server.postGetName(room_num);
                    //st2.connectToStompServer();
                    //st2.subscribeToStompServer();
                    //Test
                    //List<String> response = ["test1","test1","test1","test1"];
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => NextScreen(response, TEST_ROOM_NUMBER)),
                      MaterialPageRoute(
                          builder: (context) => MakeRoom(
                                usr_names: response,
                                room_number: room_num,
                                usr_name: usr_name,
                              )),
                      //server.post_usr_name_req(usr_name),
                    );
                  }
                },
                child: Text('방 생성'),
              ),
              Text("$room_num"),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '방 번호',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      room_num = value;
                    });
                  },
                ),
                width: 150,
              ),
              ElevatedButton(
                onPressed: () async {
                  //StompServer2 st2 = StompServer2(room_number: room_num);
                  server.postParticipateRoom(room_num, usr_name);
                  final List<String> response =
                      await server.postGetName(room_num);
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => NextScreen(response, TEST_ROOM_NUMBER)),
                    MaterialPageRoute(
                        builder: (context) => MakeRoom(
                              usr_names: response,
                              room_number: room_num,
                              usr_name: usr_name,
                            )),
                    //server.post_usr_name_req(usr_name),
                  );
                },
                child: Text('방 입장'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JsonParse()));
                },
                child: Text('http test'),
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '메세지 전송',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    message = value;
                  },
                ),
                width: 150,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.connectToStompServer();
                    },
                    child: Text('stomp activate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.disconnectFromStompServer();
                    },
                    child: Text('stomp disconnect'),
                  ),
                  StreamBuilder(
                      //stream: widget.ws.channel.stream,
                      stream: st2.dataStreamController.stream,
                      builder: (context, snapshot) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Container(
                                child: Text(snapshot.hasData
                                    ? '${snapshot.data}'
                                    : 'data'),
                                color: Colors.blueGrey));
                      }),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.testSubscribeAppStartToStompServer();
                    },
                    child: Text('stomp subscribe(app)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.cancelFromStompServer();
                    },
                    child: Text('stomp cancel'),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.testSubscribeToStompServer();
                    },
                    child: Text('stomp subscribe(topic)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //StompServer2 st2 = StompServer2(room_number: room_num);
                      st2.cancelFromStompServer();
                    },
                    child: Text('stomp cancel'),
                  ),
                ],
              ),
              StreamBuilder(
                  //stream: widget.ws.channel.stream,
                  stream: st2.dataStreamController.stream,
                  builder: (context, snapshot) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Container(
                            child: Text(snapshot.hasData
                                ? '${snapshot.data}'
                                : 'waiting data'),
                            color: Colors.blueGrey));
                  }),
              ElevatedButton(
                onPressed: () {
                  //StompServer2 st2 = StompServer2(room_number: room_num);
                  st2.testSend(message);
                },
                child: Text('stomp send'),
              ),
            ],
          ))
        ]),
      ),
    )));
  }
}

void showToast() {
  Fluttertoast.showToast(
      msg: "사용자 명을 입력해주세요",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}

void showToastItem(Response item) {
  Fluttertoast.showToast(
      msg: "$item",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}
