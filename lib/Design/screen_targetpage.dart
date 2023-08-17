import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_pick_answer.dart";
import "package:untitled2/screen_pick_answer2.dart";
import "package:untitled2/tests/dio_server.dart";

class DesignedRoomPick extends StatelessWidget{
  DesignedRoomPick({ Key? key }) : super(key: key);
 @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image_background.png'),
              fit: BoxFit.cover
            )
          ),
          child: Center(
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Column(
                      children: [
                        WaitLetterBox(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children : [
                              Container(
                                child:
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(245, 242, 227, 1),
                                    ),
                                    child: const Text('GO'),
                                    onPressed: () async {
                                      List<String> response = await server.postGetAnswer("1234", 1, executeWithArbitraryValue: true);
                                      List<String> responseName = await server.postGetName("1234",executeWithArbitraryValue: true);
                                      print(response);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ScreenSelectAnswer2(response,responseName)));

                                    }
                                ),
                              ),
                              Container(
                                width: 25,
                              ),
                              Container(
                                  child:
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(245, 242, 227, 1),
                                    ),
                                    child: const Text(
                                        '돌아가기',
                                      style: TextStyle(fontFamily: "DO",),
                                    ),
                                    onPressed: (){Navigator.pop(context);},
                                  )
                              ),
                            ]
                        ),
                      ],
                    )

                  ]
              )
          ),
        )
    );
  }
}


class WaitLetterBox extends StatelessWidget{
  WaitLetterBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Image.asset('assets/images/image_waiting.png'),
      );
  }
}

