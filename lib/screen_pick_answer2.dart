
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_result.dart";
import "package:untitled2/tests/dio_server.dart";

class ScreenSelectAnswer2 extends StatefulWidget{
  HttpServer server = HttpServer();
  late List<String> answers;
  late List<String> usr_names;
  ScreenSelectAnswer2(List<String> answers, List<String> usr_names, {super.key}){
    this.answers = answers;
    this.usr_names = usr_names;
  }
  @override
  State<StatefulWidget> createState() {
    return ScreenSelectorAnswer2Page(answers,usr_names);
  }
}

class ScreenSelectorAnswer2Page extends State<ScreenSelectAnswer2>{
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