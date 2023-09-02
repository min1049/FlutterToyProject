import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_pick_answer.dart";
import "package:untitled2/screen_pick_answer2.dart";
import "package:untitled2/tests/dio_server.dart";

class RoomPick extends StatelessWidget{
  RoomPick({ Key? key }) : super(key: key);

  HttpServer server = HttpServer();

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