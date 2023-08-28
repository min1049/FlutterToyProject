import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/Design/screen_selectpage.dart";
import "package:untitled2/app_colors.dart";
import "package:untitled2/screen_pick_answer.dart";
import "package:untitled2/screen_pick_answer2.dart";
import "package:untitled2/tests/dio_server.dart";

class DesignedRoomPick extends StatelessWidget{
  late Map<String, dynamic> room_information;
  DesignedRoomPick({ Key? key ,required this.room_information}) : super(key: key);
 @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 10,right:10),
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children : [
                              Container(
                                child:
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: MyColors().getSkyblue(),
                                    ),
                                    child: const Text('GO'),
                                    onPressed: () async {
                                      List<String> response = await server.postGetAnswer("1235", 1); //2번째 파라미터 '1'은 라운드 숫자임
                                      List<String> responseName = await server.postGetName("1235");
                                      print(response);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DesignedSelectPage(response,room_information)));
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
                                      primary: MyColors().getSkyblue(),
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
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: MyColors().getWhite(),
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
        child:
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Text(
                    "당신은 술래입니다",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                )),
                Text(
                    "상대방이 입력을 종료할때까지 기다리세요",
                    style: TextStyle(
                    color: Colors.black54,
                      fontSize: 15,
                  ),
                )
              ],
            ),
          )
      )
      );
  }
}

