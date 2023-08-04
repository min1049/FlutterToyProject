import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_writer.dart";
import "package:untitled2/tests/dio_server.dart";

import "main.dart";

class MakeRoom extends StatefulWidget{
  late List<String> usr_names;
  late String room_number;
  MakeRoom({super.key,required this.usr_names,required this.room_number});

  @override
  State<StatefulWidget> createState() => _startMakeRoom(usr_names: this.usr_names);

}

class _startMakeRoom extends State<StatefulWidget>{
  late List<UserInfo> room_info;
  late List<String> usr_names;
  late int player_num;


  _startMakeRoom({Key? key, required this.usr_names});

  String room_number = "test";

  final double human_icon_size = 75;
  final double between_human_chatbox = 200;

  int countPlayerInRoom(){
    int count = usr_names.length;
    return count;
  }
  int counter = 0;

  void updateStateEverySecond() {
    setState(() {
      // 여기에서 상태를 업데이트합니다 (예: 카운터 증가)
      counter++;
      print(counter);
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      updateStateEverySecond();
      _updateState();
    });

    this.player_num = countPlayerInRoom();
    room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names[index]));
    room_info.forEach((UserInfo) {
      print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
    });
  }

  void _updateState() async {
    // 필요한 경우 여기에서 비동기 작업 수행
    final List<String> response = await server.postGetName("1234",executeWithArbitraryValue: true);

    setState((){
      //List<dynamic> responseData = List<dynamic>.from(response.body);
      //players = responseData.map((playerData) => Player(playerData['name'], playerData['score'])).toList();
      this.usr_names = response;
      this.player_num = countPlayerInRoom();
      room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names[index]));
      room_info.forEach((UserInfo) {
        print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
      });
    });
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
                  Text("카운트 확인 $counter"),
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
  double between_human_chatbox = 10;

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
                    onPressed: (){Navigator.push(context,
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