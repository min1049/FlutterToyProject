import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/make_room.dart';
import 'package:untitled2/make_room2.dart';
import 'package:untitled2/tests/json_parse.dart';
import 'package:untitled2/tests/dio_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/tests/ws_server.dart';
import 'package:untitled2/tests/ws_stomp_server.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectPlayerState(),
    );
  }
}

class SelectPlayerState extends StatefulWidget {
  @override
  _SelectPlayerState createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayerState>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.push(
                            context,
                              MaterialPageRoute(builder : (context) => StartPage(usrname: "Player1"))
                            );
                        },child: Text("Player1")),
                        ElevatedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder : (context) => StartPage(usrname: "Player2"))
                          );
                        },child: Text("Player2")),
                        ElevatedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder : (context) => StartPage(usrname: "Player3"))
                          );
                        },child: Text("Player3")),
                        ElevatedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder : (context) => StartPage(usrname: "Player4"))
                          );
                        },child: Text("Player4")),
                      ],
                    ),
                    Container(

                    )
                  ],
                )
            )
        )
    );
  }
}

class StartPage extends StatefulWidget {
  late String usrname;
  WSServer ws = WSServer();
  //StompServer st = StompServer();
  StartPage({Key? key, required this.usrname}) : super(key: key);
  //StartPage.SelectPlayer({Key? key, required this.usrname}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StartPageState(usr_name: usrname);
  }
}

class StartPageState extends State<StartPage>{
  late String usr_name;
  String room_num = "1234";
  StartPageState({required this.usr_name});

  static const String TEST_ROOM_NUMBER = "1234";

  Server server = Server(); // http 전용 서버 생성

  late Response getItem;

  //stomp 전용 서버 생성
  String message = '';


  @override
  Widget build(BuildContext context){
    StompServer2 st2 = StompServer2(room_number: room_num);
    return MaterialApp(
        home : Scaffold(
            body :
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("현재 플레이어 : $usr_name"),
                    Container(
                      child:
                      Text("시작화면"),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '닉네임',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          usr_name = value;
                        },
                      ),
                      width: 150,
                    ),
                    Container(
                        child:
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if(usr_name == ""){
                                  showToast();
                                }
                                else{
                                  //StompServer2 st2 = StompServer2(room_number: room_num);
                                  server.postCreateRoom(room_num,usr_name);
                                  st2.connectToStompServer();
                                  final List<String> response = await server.postGetName(room_num);
                                  Navigator.push(
                                    context,
                                    //MaterialPageRoute(builder: (context) => NextScreen(response, TEST_ROOM_NUMBER)),
                                    MaterialPageRoute(builder: (context) => MakeRoom(usr_names: response,room_number: TEST_ROOM_NUMBER,)),
                                    //server.post_usr_name_req(usr_name),
                                  );
                                }
                              },
                              child: Text('방 생성'),
                            ),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '방 번호',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
                                  room_num = value;
                                },
                              ),
                              width: 150,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                //StompServer2 st2 = StompServer2(room_number: room_num);
                                server.postParticipateRoom(room_num,usr_name);
                                final List<String> response = await server.postGetName(room_num);

                                Navigator.push(
                                  context,
                                  //MaterialPageRoute(builder: (context) => NextScreen(response, TEST_ROOM_NUMBER)),
                                  MaterialPageRoute(builder: (context) => MakeRoom(usr_names: response,room_number: room_num,)),
                                  //server.post_usr_name_req(usr_name),
                                );

                              },
                              child: Text('방 입장'),
                            ),
                            ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => JsonParse())
                                );
                              },
                              child: Text('http test'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getItem = server.testGetReq() as Response;
                                showToastItem(getItem);
                              },
                              child: Text('테스트 용 버튼'),
                            ),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '메세지 전송',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value){
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
                                  child: Text('stomp test'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //StompServer2 st2 = StompServer2(room_number: room_num);
                                    st2.disconnectFromStompServer();
                                  },
                                  child: Text('stomp disconnect'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //StompServer2 st2 = StompServer2(room_number: room_num);
                                    st2.send(message);
                                  },
                                  child: Text('stomp send'),
                                ),
                                StreamBuilder(
                                    //stream: widget.ws.channel.stream,
                                    stream: st2.dataStreamController.stream,
                                    builder: (context, snapshot){
                                      return Padding(
                                        padding : const EdgeInsets.symmetric(vertical: 24.0),
                                        child: Container(
                                          child : Text(snapshot.hasData ? '${snapshot.data}' : ''),
                                          color : Colors.blueGrey
                                        )
                                      );
                                    }
                                )
                              ],
                            ),

                          ],
                        )
                    )
                  ]
              ),
            )
        )
    );
  }

}

void showToast(){
  Fluttertoast.showToast(
      msg: "사용자 명을 입력해주세요",
      gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.redAccent,
  fontSize: 20,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_SHORT);
}

void showToastItem(Response item){
  Fluttertoast.showToast(
      msg: "$item",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}