import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_writer.dart";
import "package:untitled2/start_page.dart";
import "package:untitled2/tests/dio_server.dart";
import "package:untitled2/tests/ws_stomp_server.dart";

import "main.dart";

class MakeRoom extends StatefulWidget{
  late List<String> usr_names;
  late String room_number;
  late String usr_name;
  MakeRoom({super.key,required this.usr_names,required this.room_number,required this.usr_name});

  @override
  State<StatefulWidget> createState() => _startMakeRoom(
    usr_names: this.usr_names,
    room_number: this.room_number,
    usr_name: this.usr_name,
  );


}

class _startMakeRoom extends State<StatefulWidget>{
  late List<UserInfo> room_info;
  late List<dynamic> usr_names;
  late int player_num;
  late String room_number;
  late String usr_name;
  late StompServer2 st2;
  String? status = "Default";
  _startMakeRoom({Key? key, required this.usr_names,required this.room_number,required this.usr_name});

  HttpServer httpServer = HttpServer();
  final double human_icon_size = 75;
  final double between_human_chatbox = 200;


  int counter = 0;
  int countPlayerInRoom(){
    int count = usr_names.length;
    return count;
  }


  /*
  void updateStateEverySecond() {
    setState(() {
      // 여기에서 상태를 업데이트합니다 (예: 카운터 증가)
      counter++;
      print(counter);
    });
  }
   */

  @override
  void initState() {
    super.initState();
    st2 = StompServer2(room_number: room_number);
    _setStomp();
    Timer.periodic(Duration(seconds: 5), (timer) {
      //updateStateEverySecond();
      _updateState();
    });

    this.player_num = countPlayerInRoom();
    room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names[index]));
    room_info.forEach((UserInfo) {
      //print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
    });

  }

  void _setStomp() async {
    st2.connectToStompServer();
    st2.subscribeToStompServer();
  }

  void _updateState() async {
    // 필요한 경우 여기에서 비동기 작업 수행
    final List<dynamic> response = await server.postGetName(room_number);
    if(mounted){
      setState((){
        //List<dynamic> responseData = List<dynamic>.from(response.body);
        //players = responseData.map((playerData) => Player(playerData['name'], playerData['score'])).toList();
        this.usr_names = response;
        this.player_num = countPlayerInRoom();
        room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names[index]));
        room_info.forEach((UserInfo) {
          //print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  SizedBox(height: 10.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("방 번호: $room_number"),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children : [
                        Container(
                            child:
                            ElevatedButton(
                                child: const Text('게임 시작하기'),
                                onPressed: () {
                                  // 사용자의 상태마다 화면 실행 상태 코드를 받아야함
                                  st2.send(destination: "GameStart");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RoomPick())
                                    // 게임을 시작하는 신호를 서버로 보냄냄
                                  );
                                }
                            )
                        ),
                        Container(
                            child:
                            ElevatedButton(
                                child: const Text('메세지 보내기'),
                                onPressed: () {
                                  // 사용자의 상태마다 화면 실행 상태 코드를 받아야함
                                  st2.subscribeAppToStompServer(destination: "Start");
                                }
                            )
                        ),
                        ElevatedButton(
                            onPressed: (){
                              _updateState();
                            },
                            child: Icon(
                                Icons.refresh_rounded
                            )
                        )
                      ]
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: player_num,
                    itemBuilder: (context, index) {
                      return PlayerBox(usr_names: room_info[index].name);
                    },
                  ),
                  Container(
                    height: between_human_chatbox,
                  ),
                  Text(
                    "status : $status",

                  ),
                  StreamBuilder(
                    //stream: widget.ws.channel.stream,
                      stream: st2.dataStreamController.stream,
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
                      stream: st2.dataStreamController.stream,
                      builder: (context, snapshot){
                        if (snapshot.hasData) {

                          // 스트림으로부터 새로운 데이터가 도착하면 ListView에 추가
                          return ListView.builder(
                            itemCount: st2.message.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(st2.message[index]),
                              );
                            },
                          );
                        } else {
                          // 스트림에 데이터가 없는 경우 또는 초기 상태
                          return CircularProgressIndicator();
                        }
                      }
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
                              child: const Text('돌아가기!!!'),
                              onPressed: () {
                                httpServer.exitRoom(room_number, usr_name);
                                st2.send(destination: 'Exit');
                                st2.cancelFromStompServer();
                                st2.disconnectFromStompServer();
                                Navigator.pop(context);
                              }
                            )
                        ),
                      ]
                  )
                ]
            )

        ),
    );
  }}


class ListViewPlayerBox extends StatefulWidget{
  late int player_num;
  late List<UserInfo> room_info;

  ListViewPlayerBox({Key? key,required this.player_num, required this.room_info});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: player_num,
      itemBuilder: (context, index) {
        return ListTile(
          title: PlayerBox(usr_names: room_info[index].name),
          //trailing: lastWidget(),
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class PlayerBox extends StatelessWidget{
  late String usr_names;

  PlayerBox({required this.usr_names});
  final double human_icon_size = 75;
  final double between_human_chatbox = 300;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // Border radius
          border: Border.all(
            color: Colors.black54, // Outline color
            width: 2, // Outline width
          ),
        ),
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.man,
              color: Colors.black,
              size: human_icon_size,
            ),
            Text(usr_names),
          ],
        )
      )
    );
  }
}

class lastWidget extends StatelessWidget{
  late String room_number;
  late String usr_name;
  lastWidget({required this.room_number, required this.usr_name, Key? key});
  double between_human_chatbox = 10;
  StompServer2 st2 = StompServer2(room_number: "1234");
  HttpServer httpServer = HttpServer();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
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
                    onPressed: (){
                      //http 요청 : DB에서 사용자 삭제

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartPage(usrname: "돌아가기",)));},
                  )
              ),
            ]
        )
      ],
    );
  }

}

class UserInfo{
  String name;
  bool isRoom = true;

  UserInfo({required this.name});
}