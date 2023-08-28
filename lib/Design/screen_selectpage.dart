
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/app_colors.dart";
import "package:untitled2/screen_result.dart";
import "package:untitled2/tests/dio_server.dart";

class DesignedSelectPage extends StatefulWidget{
  HttpServer server = HttpServer();
  late Map<String, dynamic> room_information;
  late List<String> answers;
  late List<String> usr_names;
  late dynamic room_id;
  DesignedSelectPage(List<String> answers, Map<String,dynamic> room_information, {super.key}){
    this.answers = answers;
    this.room_information = room_information;
    print("room_information[\"usr_names\"] : ${room_information["usr_names"]}");
    this.usr_names = room_information["usr_names"];
    print("usr_names : ${usr_names}");
    room_id = room_information["room_id"];
  }
  @override
  State<StatefulWidget> createState() {
    return DesignedSelectPageForm(answers,room_information);
  }
}

class DesignedSelectPageForm extends State<DesignedSelectPage>{
  late int selectCount;
  late int expressSelect;
  late String topic;
  bool answerClear = false;
  late List<String> answers;
  late List<String> usr_names;
  late Map<String, dynamic> room_information;
  late String picker;
  late List<String> writerList;

  Color _buttonColor1 = MyColors().getSkyblue();
  Color _buttonColor2 = MyColors().getSkyblue();
  Color _buttonColor3 = MyColors().getSkyblue();

  DesignedSelectPageForm(List<String> answers, Map<String, dynamic> room_informaiton,{ Key? key }){
    this.answers = answers;
    this.room_information = room_informaiton;
    this.usr_names = room_informaiton["usr_names"];
    this.picker = room_information["picker"];
    this.writerList = room_information["writer"];
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
                  Text("술래의 이름은 \n ${picker}",
                      style: TextStyle(fontSize: 50,),
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
                  Text("$topic \n 작성한 사람은 누구?\n",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text("$expressSelect / 3",
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
                              child: Text(writerList[0],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor1 = Colors.black12;
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
                              child: Text(writerList[1],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor2 = Colors.black12;
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
                              child: Text(writerList[2],
                                style: TextStyle(fontSize: 30),),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                                _buttonColor3 = Colors.black12;
                              },
                            )

                        ),
                      ],
                    ),

                  ),
                  /*
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Container(
                            child:
                            ElevatedButton(
                              child: const Text('모든 정답 입력 완료'),
                              onPressed: (){

                                Navigator.push(context,
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


                   */
                ]
            )
        )
    );
  }
}