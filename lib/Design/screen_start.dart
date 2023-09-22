import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/Design/screen_selectpage.dart";
import "package:untitled2/Design/screen_targetpage.dart";
import "package:untitled2/Design/screen_whoispicker.dart";
import "package:untitled2/Design/screen_writepage.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_writer.dart";
import "package:untitled2/start_page.dart";
import "package:untitled2/tests/ws_stomp_server.dart";

import "../app_colors.dart";
import "../tests/dio_server.dart";


class DesignedStartPage extends StatefulWidget {
  var usr_names;
  var room_id;
  var round;
  var usr_name;
  var usr_count;
  late StompServer2 st;

  late List<dynamic>? response;

  late Map<String, dynamic> room_information = {
    "usr_name" : usr_name,
    "room_id" : room_id,
    "usr_names" : usr_names,
    "round" : round,
    "usr_count" : usr_count,
  };

  int countUserInRoom(){
    int count = usr_names.length;
    return count;
  }

  void getResponse({required room_num}) async {
    response = await server.postGetName(room_num!);
  }

  DesignedStartPage({ Key? key , required this.usr_name, this.usr_names, required this.room_id, required this.round}) : super(key: key){
    print("유저 이름 : ${usr_names}");
    print("방 번호 : ${room_id}");
    st = StompServer2(room_number: room_id,usr_name: usr_name);
    usr_count = countUserInRoom();
  }

  @override
  State<StatefulWidget> createState() {
    getResponse(room_num: room_id);
    usr_count = countUserInRoom();
    return DesignedStartPageForm(usr_names: usr_names, usr_count: usr_count);
  }
}

class DesignedStartPageForm extends State<DesignedStartPage>{
  late List<String> usr_names;
  late int usr_count;

  @override
  void initState() {
    super.initState();
  }

  List<String> writerList = [];

  DesignedStartPageForm({required this.usr_names, required this.usr_count, Key? key,}){

  }

  final double human_icon_size = 75;
  final double between_human_chatbox = 300;



  void makeWriterList(){
    writerList = [];
    if(writerList.length == 4){
      return;
    }
    for(var i in widget.usr_names){
      print("술래인 유저 : ${widget.room_information["picker"]}");
      if(widget.room_information["picker"] != i){
        print("확인중인 유저 이름 : $i");
        writerList.add(i);
      }
      else{
        print("술래인 유저입니다.");
      }
    }
    print(writerList);
  }



  Widget buildPlayerBoxWidget({required BuildContext context, required usr_count, required usr_names}){
    if(usr_count == 2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width/5 * 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PlayerBox(usr_names: usr_names[0]),
                ]
            )
          ),
          Container(
            width: 10,
          ),
          Container(
              width: MediaQuery.sizeOf(context).width/5 * 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PlayerBox(usr_names: usr_names[1]),
                  ]
              )
          ),
        ],
      );
    }
    else if(usr_count == 3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.sizeOf(context).width/5 * 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PlayerBox(usr_names: usr_names[0]),
                    PlayerBox(usr_names: usr_names[2]),
                  ]
              )
          ),
          Container(
            width: 10,
          ),
          Container(
              width: MediaQuery.sizeOf(context).width/5 * 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PlayerBox(usr_names: usr_names[1]),
                  ]
              )
          ),
        ],
      );
    }
    else if(usr_count == 4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.sizeOf(context).width/5 * 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PlayerBox(usr_names: usr_names[0]),
                    PlayerBox(usr_names: usr_names[2]),
                  ]
              )
          ),
          Container(
            width: 10,
          ),
          Container(
              width: MediaQuery.sizeOf(context).width/5 * 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PlayerBox(usr_names: usr_names[1]),
                    PlayerBox(usr_names: usr_names[3]),
                  ]
              )
          ),
        ],
      );
    }
    else
      return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.sizeOf(context).width/5 * 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PlayerBox(usr_names: usr_names[0]),
                ]
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    String? status = "Default";
    return WillPopScope(
      onWillPop: () async{
        // 뒤로가기 막아놈
        /*
        print("뒤로가기");
        server.postExit(room_id: widget.room_number, usr_name: widget.usr_name);
        widget.st.send(destination: 'Exit');
        widget.st.cancelFromStompServer();
        widget.st.disconnectFromStompServer();
        Navigator.pop(context,
            MaterialPageRoute(builder: (context) => StartPage(usrname: "돌아가기",)));

         */

        return false;
      },
        child: Scaffold(
          body: Container(
                margin: EdgeInsets.only(left: 10,right:10),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          SizedBox(height: MediaQuery.of(context).size.height/12),
                          StreamBuilder(
                            //stream: widget.ws.channel.stream,
                              stream: widget.st.dataStreamController.stream,
                              builder: (context, snapshot){
                                status = snapshot.data;
                                return Padding(
                                    padding : const EdgeInsets.symmetric(vertical: 24.0),
                                    child: Container(
                                        child : Text(snapshot.hasData ? '${snapshot.data}' : 'Nothing'),
                                        color : Colors.blueGrey
                                    )
                                );
                              }
                          ),
                          StreamBuilder(
                            //stream: widget.ws.channel.stream,
                              stream: widget.st.dataStreamController.stream,
                              builder: (context, snapshot){
                                if (snapshot.hasData) {

                                  // 스트림으로부터 새로운 데이터가 도착하면 ListView에 추가
                                  return ListView.builder(
                                    itemCount: widget.st.message.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(widget.st.message[index]),
                                      );
                                    },
                                  );
                                } else {
                                  // 스트림에 데이터가 없는 경우 또는 초기 상태
                                  return CircularProgressIndicator();
                                }
                              }
                          ),
                          Text("방 번호: ${widget.room_id}"),
                          Text("사용자 : ${widget.room_information["usr_name"]}"),
                          Container(
                            height: 20.0,
                          ),
                          Container(
                              height: 10
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
                              child: buildPlayerBoxWidget(context: context, usr_count: widget.usr_count, usr_names: widget.usr_names)
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 25),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                                  backgroundColor: MaterialStateProperty.all(MyColors().getSkyblue()),
                                ),
                                child: const Text('시작하기(술래 test)',
                                  style: TextStyle(
                                    fontFamily: "CAFE",
                                  ),),
                                onPressed: () async {
                                  server.postGameStart(room_id: widget.room_id);
                                  List<String> response = await server.postGetAnswer(widget.room_id, 1); //2번째 파라미터 '1'은 라운드 숫자임
                                  if(response.isEmpty){
                                    response = ["A","B","C"];
                                  }
                                  dynamic result = await server.postGetIt(room_id: widget.room_information["room_id"]);
                                  if(response.isEmpty){
                                    result = "Kim";
                                  }

                                  widget.room_information["usr_answers"] = response;
                                  widget.room_information["picker"] = result;
                                  makeWriterList();
                                  widget.room_information["writer"] = writerList;
                                  print("유저의 답변: $response");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DesignedSelectPage(response, widget.room_information))
                                  );
                                }
                            )
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(Size(200, 50)),
                                    backgroundColor: MaterialStateProperty.all(MyColors().getSkyblue()),
                                  ),
                                  child: const Text('시작하기(작성자 test)',
                                    style: TextStyle(
                                      fontFamily: "CAFE",
                                    ),),
                                  onPressed: () async {
                                    server.postGameStart(room_id: widget.room_id);
                                    //List<String> response = await server.postGetAnswer(widget.room_id, 1); //2번째 파라미터 '1'은 라운드 숫자임
                                    String result = await server.postGetIt(room_id: widget.room_information["room_id"]);
                                    widget.room_information["writer"] = writerList;
                                    //widget.room_information["usr_answers"] = response;
                                    widget.room_information["picker"] = result;
                                    makeWriterList();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DesignedWritePage(room_information:widget.room_information,))
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
                                        child: const Text('게임종료'),
                                        onPressed: () {
                                          /*
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DesignedRoomPick(room_information: widget.room_information,))
                                          );

                                           */
                                          server.postFinish(room_id: widget.room_information["room_id"]);
                                        }
                                    )
                                ),
                                Container(
                                    child:
                                    ElevatedButton(
                                        child: const Text('시작하기(작성자)'),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DesignedWhoisPickerPage(room_information: widget.room_information,))
                                          );}
                                    )
                                ),
                                Container(
                                    child:
                                    ElevatedButton(
                                      child: const Text('돌아가기'),
                                      onPressed: (){
                                        server.postExit(room_id: widget.room_id, usr_name: widget.usr_name);

                                        Navigator.pop(context,
                                          MaterialPageRoute(builder: (context) => StartPage(usrname: "돌아가기",)));},
                                    )
                                ),
                              ]
                          )
                        ]
                    )

                ),
              ),
          ),
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
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: [
              Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child:Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3), // 그림자 색상과 투명도 설정
                                spreadRadius: 1, // 그림자 확산 정도
                                blurRadius: 5, // 그림자의 흐릿한 정도
                                offset: Offset(0, 3), // 그림자의 위치 (x, y)
                              ),
                            ],
                          ),
                          //color: MyColors().getWhite(),
                          //이미지 구현 child로 사용
                        )
                      ),
                      Text(usr_names,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "CAFE",
                          ) ),
                    ],
                  )
              ),
              ),
              ],
            ),

            )
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