import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_result.dart";

class ScreenSelectAnswer extends StatelessWidget{
  ScreenSelectAnswer({ Key? key }) : super(key: key);
  final String Answer1 = "개";
  final String Answer2 = "고양이";
  final String Answer3 = "고슴도치";
  final BorderRadius _baseRadiusBorder = BorderRadius.circular(8);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Text("(1/3)",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text("$Answer1",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height : 100, width: 300,
                          child:
                              Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: _baseRadiusBorder),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children : [
                                        Text('Player2',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ]
                                    ),
                                  )
                              )
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child:
                            Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: _baseRadiusBorder),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children : [
                                        Text('Player3',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                            )
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child:
                            Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: _baseRadiusBorder),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children : [
                                        Text('Player4',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ]
                                  ),
                                )
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