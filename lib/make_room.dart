import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_writer.dart";

import "main.dart";

class NextScreen extends StatelessWidget{
  late List<String> usr_names;
  late String room_number;
  NextScreen(List<String> usr_names,String room_number, { Key? key }) : super(key: key){
    this.usr_names = usr_names;
    this.room_number = room_number;
  }
  NextScreen.Comeback({ Key? key }) : super(key: key);
  
  String name2 = "Player2";
  String name3 = "Player3";
  String name4 = "Player4";

  final double human_icon_size = 75;
  final double between_human_chatbox = 300;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children : [
            SizedBox(height: 40.0),
            Text("방 번호: $room_number"),
            Container(
              height: 20.0,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.man,
                    color: Colors.redAccent,
                    size: human_icon_size,
                  ),
                  Text(usr_names[0]),
                ],
              )
            ),
            Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.man,
                      color: Colors.redAccent,
                      size: human_icon_size,
                    ),
                    Text(usr_names[1]),
                  ],
                )
            ),
            Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.man,
                      color: Colors.redAccent,
                      size: human_icon_size,
                    ),
                    Text(usr_names[2]),
                  ],
                )
            ),
            Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.man,
                      color: Colors.redAccent,
                      size: human_icon_size,
                    ),
                    Text(usr_names[3]),
                  ],
                )
            ),
            Container(
              height: between_human_chatbox,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  // 텍스트 입력 필드
                  Flexible(
                    child: TextField(
                      /*
                      controller: _textController,
                      // 입력된 텍스트에 변화가 있을 때 마다
                      onChanged: (text) {
                        setState(() {
                          _isComposing = text.length > 0;
                        });
                      },
                      // 키보드상에서 확인을 누를 경우. 입력값이 있을 때에만 _handleSubmitted 호출
                      onSubmitted: _isComposing ? _handleSubmitted : null,
                      // 텍스트 필드에 힌트 텍스트 추가
                      */
                      decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                    ),
                  ),
                  // 전송 버튼
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),

                    // 플랫폼 종류에 따라 적당한 버튼 추가

                    child: Theme.of(context).platform == TargetPlatform.iOS
                        ? CupertinoButton(
                      child: Text("send"),

                      onPressed: (){}


                    )
                        : IconButton(
                      // 아이콘 버튼에 전송 아이콘 추가
                      icon: Icon(Icons.send),
                      // 입력된 텍스트가 존재할 경우에만 _handleSubmitted 호출

                      onPressed: (){}


                    ),
                  ),
                ],
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child:
                    ElevatedButton(
                      child: const Text('시작하기(술래)'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RoomPick())
                    );}
                    )
                ),
                Container(
                  width: 25.0
                ),
                Container(
                    child:
                    ElevatedButton(
                        child: const Text('시작하기(작성자)'),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RoomWriter())
                          );}
                    )
                ),
                Container(
                    width: 25.0
                ),
                Container(
                    child:
                    ElevatedButton(
                      child: const Text('돌아가기'),
                      onPressed: (){Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StartPage(usrname: "돌아가기",)));},
                    )
                ),
              ]
            )
          ]
        )

    )
    );
  }
}