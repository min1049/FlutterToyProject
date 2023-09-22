import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:untitled2/screen_pick.dart";
import "package:untitled2/screen_pick_answer2.dart";
import "package:untitled2/screen_result.dart";
import "package:untitled2/screen_writer.dart";
import "package:untitled2/start_page.dart";
import "package:untitled2/tests/dio_server.dart";
import "package:untitled2/tests/ws_stomp_server.dart";

import "main.dart";

class GamePage extends StatefulWidget{
  late List<String> usr_names;
  late String room_number;
  late String state_code;
  GamePage({super.key,required this.usr_names,required this.room_number,required this.state_code});

  @override
  State<StatefulWidget> createState() => pickPage();
}

class pickPage extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Text("당신은 술래입니다. \n상대방이 입력을 \n종료할 때까지 \n기다리세요",
                    style: TextStyle(fontSize: 42),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Container(
                          child:
                          ElevatedButton(
                              child: const Text('입력 완료'),
                              onPressed: () async {
                                List<String> response = await server.postGetAnswer("1234", 1, executeWithArbitraryValue: true);
                                List<dynamic>? responseName = await server.postGetName("1234",executeWithArbitraryValue: true);
                                print(response);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ScreenSelectAnswer2(response,responseName!)));

                              }
                          ),
                        ),
                        Container(
                          width: 25,
                        ),
                        Container(
                            child:
                            ElevatedButton(
                              child: const Text('돌아가기'),
                              onPressed: (){Navigator.pop(context);},
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

class writePage extends State<StatefulWidget>{
  late int selectCount;
  late int expressSelect;
  late String topic;
  bool answerClear = false;
  late List<String> answers;
  late List<String> usr_names;
  Color _buttonColor1 = Colors.blue;
  Color _buttonColor2 = Colors.blue;
  Color _buttonColor3 = Colors.blue;

  ScreenSelectorAnswer2Page(List<String> answers, List<String> usr_names,{ Key? key }){
    this.answers = answers;
    this.usr_names = usr_names;
  }

  @override
  void initState() {
    super.initState();

    selectCount = 0;
    expressSelect = 1;

    if(selectCount == 0){
      topic = answers[selectCount];
    }
  }

  void answerSubmit(){
    if(selectCount == 2){
      answerClear = true;
    }
    setState((){
      if(answerClear){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScreenResult(),)
          ,);
      }
      else{
        selectCount++;
        expressSelect++;
        topic = answers[selectCount];
      }
    });
  }

  final BorderRadius _baseRadiusBorder = BorderRadius.circular(8);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Text("술래 : ${usr_names[0]}",
                      style: TextStyle(fontSize: 50)),
                  Text("$expressSelect / 3",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  /*
                  FutureBuilder <List<String>>(
                    future: answers,
                    builder : (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }
                      else if (snapshot.hasError){
                        return Text("Error! ${snapshot.error} ");
                      } else {
                        responseData = snapshot.data ?? [];
                        return ElevatedButton(onPressed: (){
                          print('Response data from POST request:');
                          print(responseData[0]);
                          print(responseData[1]);
                          print(responseData[2]);
                          },
                          child: Text("test"),);
                      }
                    }
                  ),

                   */
                  Text("대답 : $topic",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _buttonColor1,
                              ),
                              child: Text(usr_names[1],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor1 = Colors.blueGrey;
                              },
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _buttonColor2,
                              ),
                              child: Text(usr_names[2],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor2 = Colors.blueGrey;
                              },
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _buttonColor3,
                              ),
                              child: Text(usr_names[3],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor3 = Colors.blueGrey;
                              },
                            )

                        ),
                      ],
                    ),

                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Container(
                            child:
                            ElevatedButton(
                              child: const Text('모든 정답 입력 완료'),
                              onPressed: (){Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ScreenResult(),)
                                ,);},
                            )
                        ),
                        Container(
                          width: 25,
                        ),
                        Container(
                            child:
                            ElevatedButton(
                              child: const Text('돌아가기'),
                              onPressed: (){Navigator.pop(context);},
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

class _startMakeRoom extends State<StatefulWidget>{
  late List<UserInfo> room_info;
  late List<dynamic>? usr_names;
  late int player_num;
  late String room_number;
  _startMakeRoom({Key? key, required this.usr_names,required this.room_number});

  //late StompServer2 st2 = StompServer2(room_number: this.room_number);

  final double human_icon_size = 75;
  final double between_human_chatbox = 200;



  int countPlayerInRoom(){

    if(usr_names == null){
      return 0;
    }
    else{
      int count = (usr_names!.length);
      return count;
    }
  }
  int counter = 0;

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

    Timer.periodic(Duration(seconds: 5), (timer) {
      //updateStateEverySecond();
      _updateState();
    });

    this.player_num = countPlayerInRoom();
    room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names![index]));
    room_info.forEach((UserInfo) {
      //print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
    });
  }

  void _updateState() async {
    // 필요한 경우 여기에서 비동기 작업 수행
    final List<dynamic>? response = await server.postGetName(room_number);

    setState((){
      //List<dynamic> responseData = List<dynamic>.from(response.body);
      //players = responseData.map((playerData) => Player(playerData['name'], playerData['score'])).toList();
      this.usr_names = response;
      this.player_num = countPlayerInRoom();
      room_info = List.generate(this.player_num, (index) => UserInfo(name: this.usr_names![index]));
      room_info.forEach((UserInfo) {
        //print('Player Name: ${UserInfo.name}, Score: ${UserInfo.isRoom}');
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
                      Container(
                          child:
                          ElevatedButton(
                              child: const Text('게임 시작하기'),
                              onPressed: () {
                                // 사용자의 상태마다 화면 실행 상태 코드를 받아야함
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RoomPick())
                                  // 게임을 시작하는 신호를 서버로 보냄냄
                                );
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

                              Navigator.push(context,
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
  StompServer2 st2 = StompServer2(room_number: "1234");
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
                      st2.cancelFromStompServer();
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