import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/make_room.dart';
import 'package:untitled2/make_room2.dart';
import 'package:untitled2/tests/json_parse.dart';
import 'package:untitled2/tests/dio_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/tests/ws_server.dart';

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

  late dynamic getItem;


  @override
  Widget build(BuildContext context){
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
                                  server.postCreateRoom(room_num,usr_name);
                                  final List<String> response = await server.postGetName("1234",executeWithArbitraryValue: true);
                                  //print(response);
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
                              onPressed: () {
                                server.postParticipateRoom("1234", "민수");
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
                                getItem = server.testGetReq();
                                showToastItem(getItem);
                              },
                              child: Text('테스트 용 버튼'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.ws.testWS();
                              },
                              child: Text('테스트 스크린 이동(WS)'),
                            ),
                            StreamBuilder(
                              stream: widget.ws.channel.stream,
                              builder: (context, snapshot){
                                return Padding(
                                  padding : const EdgeInsets.symmetric(vertical: 24.0),
                                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                                );
                              }
                            )
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