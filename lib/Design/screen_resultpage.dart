import "dart:io";

import "package:flutter/material.dart";
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
    return DesignedResultPageForm(correct_num: result);
  }

}

class DesignedResultPageForm extends State<DesignedResultPage>{

  late String correct_num;

  DesignedResultPageForm({Key? key, required this.correct_num}){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('술래가 $correct_num 명 맞췄습니다' ,
                  style: TextStyle(fontSize: 42),
                  textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('처음으로'),
                            onPressed: (){Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NextScreen.Comeback()));},
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