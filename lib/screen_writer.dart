import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_result.dart";
import "package:untitled2/tests/dio_server.dart";

class RoomWriter extends StatelessWidget{
  RoomWriter({ Key? key }) : super(key: key);
  final String picker = "Player1";
  final String Topic = "상대방의 첫 인상을 \n작성하세요!";
  String answer = "";

  Server server = Server();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Text("술래는 $picker 입니다. \n$Topic",
                    style: TextStyle(fontSize: 42),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: <Widget>[
                      // 텍스트 입력 필드
                      Flexible(
                        child: TextField(

                      //controller: _textController,
                      // 입력된 텍스트에 변화가 있을 때 마다
                      onChanged: (text) {
                        /*
                        setState(() {

                          _isComposing = text.length > 0;
                        });
                        */
                        answer = text;
                      },
                      // 키보드상에서 확인을 누를 경우. 입력값이 있을 때에만 _handleSubmitted 호출
                      // onSubmitted: _isComposing ? _handleSubmitted : null,
                      // 텍스트 필드에 힌트 텍스트 추가

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

                            onPressed: (){
                              //textfield 에 있는 값을 서버에 전송해야함
                              //Server.PostReq(answer);
                            }


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
                  Container(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('입력완료'),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ScreenWaiting()),);
                                server.postAnswer(answer);
                              },
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          ElevatedButton(
                            child: const Text('돌아가기'),
                            onPressed: (){Navigator.pop(context);},
                          ),
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}

class ScreenWaiting extends StatelessWidget{
  const ScreenWaiting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('유저가 다 입력할 때 까지 기다려주십시오...',
                style: TextStyle(fontSize: 42),
                textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('모든 유저가 입력완료'),
                            onPressed: (){Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScreenWaiting2()),
                            );},
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
              ],
            )
        )
    );
  }
}

class ScreenWaiting2 extends StatelessWidget{
  const ScreenWaiting2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('술래가 작성자를 유추중입니다...',
                  style: TextStyle(fontSize: 42),
                  textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('술래가 정답을 선택 완료'),
                            onPressed: (){Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ScreenResult()),);},
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
              ],
            )
        )
    );
  }
}