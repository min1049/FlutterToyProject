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
  Server server = Server();
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
                              onPressed: () {
                                if(usr_name == ""){
                                  showToast();
                                }
                                else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NextScreen(usr_name)),
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
                                  usr_name = value;
                                },
                              ),
                              width: 150,
                            ),
                            ElevatedButton(
                              onPressed: () {},
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