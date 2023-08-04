import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/make_room.dart';
import 'package:untitled2/tests/json_parse.dart';
import 'package:untitled2/tests/dio_server.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  MyApp({Key? key } ) : super(key : key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: StartPage(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}
class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StartPageState();
  }
}

class StartPageState extends State<StartPage>{
  String usr_name = "";
  String room_num = "";
  static const String TEST_ROOM_NUMBER = "1234";
  Server server = Server();
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
                                  server.postCreateRoom(room_num,"영민");
                                  List<String> response = await server.postGetName("1234");
                                  print(response);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NextScreen(response, room_num)),
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