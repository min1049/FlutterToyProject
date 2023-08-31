import "dart:io";

import "package:flutter/material.dart";
import "package:untitled2/Design/screen_selectpage.dart";
import "package:untitled2/Design/screen_start.dart";
import "package:untitled2/Design/screen_writepage.dart";
import "package:untitled2/make_room.dart";
import "package:untitled2/tests/dio_server.dart";

class DesignedResultPage extends StatefulWidget {
  HttpServer server = HttpServer();
  late Map<String, dynamic> room_information;
  late String result;

  DesignedResultPage({ Key? key, required this.room_information, required this.result})
      : super(key: key) {
    //생성자를 통해서 데이터를 받아와서 해당 갯수 만큼 correct_num에 할당 할 것
    print("room_information : ${room_information}");
    //getCorrectCount();
  }

  void getCorrectCount() async {
    result = await server.postResult(room_id: room_information["room_id"], picker: room_information["picker"]);

    print("result : $result");

  }

  @override
  State<StatefulWidget> createState() {

    //return DesignedResultPageForm();
    return DesignedResultPageForm(correct_num: result,room_information: room_information);
  }

}

class DesignedResultPageForm extends State<DesignedResultPage>{

  late String correct_num;
  late Map<String, dynamic> room_information;

  DesignedResultPageForm({Key? key, required this.correct_num, required this.room_information}){

  }

  Future<String> fetchData() async {
    // Simulate fetching data from the server
    await Future.delayed(Duration(seconds: 2));
    return "Data from server";
  }

  Future<void> nextRound() async {
    if(room_information["round"] == "1"){
      room_information["round"] = "2";
    } else if(room_information["round"] == "2"){
      room_information["round"] = "3";
    } else if(room_information["round"] == "3"){
      room_information["round"] = "4";
    }

    room_information["writeList"] = [];
    room_information["picker"] = await server.postGetIt(room_id: room_information["room_id"]);
    //종료화면을 구현해야함
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<String>(
          future: fetchData(),
          builder: (context,snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError){
                return Center(child: Text("Error loading data"));
              } else {
                return Center(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('현재 술래: ${room_information["picker"]}' ,
                          style: TextStyle(fontSize: 42),
                          textAlign: TextAlign.center,
                        ),
                        Text('$correct_num 명 맞췄습니다' ,
                          style: TextStyle(fontSize: 42),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children : [
                              Container(
                                  child:
                                  ElevatedButton(
                                    child: const Text('계속 진행하기'),
                                    onPressed: (){
                                      nextRound();
                                      print("다음 라운드 : $room_information");
                                      Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>DesignedWritePage(room_information : room_information,)));},
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
                );
              }

          },
        )
    );
  }
}