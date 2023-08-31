import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/Design/screen_selectpage.dart";
import "package:untitled2/Design/screen_targetpage.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_writer.dart";
import "package:untitled2/start_page.dart";

import "../app_colors.dart";
import "../tests/dio_server.dart";


class DesignedStartPage extends StatelessWidget{
  var usr_names;
  var room_number;
  var round;

  List<String> writerList = [];

  late Map<String, dynamic> room_information = {
    "room_id" : room_number,
    "usr_names" : usr_names,
    "round" : round,
  };

  DesignedStartPage({ Key? key , required this.usr_names, required this.room_number, required this.round}) : super(key: key){
    print("유저 이름 : ${usr_names}");
    print("방 번호 : ${room_number}");
  }
  DesignedStartPage.Comeback({ Key? key }) : super(key: key);

  final double human_icon_size = 75;
  final double between_human_chatbox = 300;

  void makeWriterList(){
    for(var i in usr_names){
      print("술래인 유저 : ${room_information["picker"]}");
      print("확인중인 유저 이름 : $i");
      if(room_information["picker"] != i){
        this.writerList.add(i);
      }
    }
    print(this.writerList);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 10,right:10),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    SizedBox(height: MediaQuery.of(context).size.height/12),
                    Text("방 번호: $room_number"),
                    Text("사용자 : "),
                    Container(
                      height: 20.0,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PlayerBox(usr_names: usr_names[0]),
                              PlayerBox(usr_names: usr_names[1]),
                            ]
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PlayerBox(usr_names: usr_names[2]),
                              PlayerBox(usr_names: usr_names[3]),
                            ]
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/10
                    ),
                    /*Container(
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
                     */
                    Container(
                        width: MediaQuery.of(context).size.width,
                      child:
                        ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(200, 50)),
                              backgroundColor: MaterialStateProperty.all(MyColors().getSkyblue()),
                            ),
                            child: const Text('시작하기(술래 test)',
                            style: TextStyle(
                              fontFamily: "CAFE",
                            ),),
                            onPressed: () async {
                              List<String> response = await server.postGetAnswer(room_number, 1); //2번째 파라미터 '1'은 라운드 숫자임
                              String result = await server.postGetIt(room_id: this.room_information["room_id"]);
                              room_information["writer"] = writerList;
                              room_information["usr_answers"] = response;
                              room_information["picker"] = result;
                              makeWriterList();
                              server.postGameStart(room_id: room_number);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DesignedSelectPage(response, room_information))
                              );
                            }
                        )
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
                                        MaterialPageRoute(builder: (context) => DesignedRoomPick(room_information: room_information,))
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

          ),
        )
    );
  }
}

class PlayerBox extends StatelessWidget{
  late String usr_names;

  PlayerBox({required this.usr_names, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Container(
        height: MediaQuery.of(context).size.height/4,
        width: (MediaQuery.of(context).size.height/4.2),
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: MyColors().getWhite(),
              borderRadius: BorderRadius.circular(20), // Border radius
              /*
              border: Border.all(
                color: Colors.black54, // Outline color
                width: 2, // Outline width
              ),
               */
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.man,
                      color: MyColors().getSkyblue(),
                      size: MediaQuery.of(context).size.height/5,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 0.5,
                          offset: Offset(2,5)
                        )
                      ],
                    ),
                    Text(usr_names,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CAFE",
                    ) ),
                  ],
                )
            )
        ),
      ),
    );
  }
}


class ShadowedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0, // Set card's elevation to 0 to remove default shadow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Shadowed Card',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}