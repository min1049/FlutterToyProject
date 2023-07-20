
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/screen_result.dart";

class ScreenSelectAnswer2 extends StatefulWidget{
  const ScreenSelectAnswer2({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenSelectorAnswer2Page();
  }
}

class ScreenSelectorAnswer2Page extends State<ScreenSelectAnswer2>{
  late int selectCount;
  late int expressSelect;
  List<String> topics = ["개","고양이","물개"];
  late String topic;
  bool answerClear = false;

  ScreenSelectorAnswer2Page({ Key? key }){
    selectCount = 0;
    expressSelect = 1;
    if(selectCount == 0){
      topic = topics[selectCount];
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
        topic = topics[selectCount];
      }
    });
  }

  String Player1 = "";
  String Player2 = "";
  String Player3 = "";
  final BorderRadius _baseRadiusBorder = BorderRadius.circular(8);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  Text("$expressSelect / 3",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text("($topic)",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              child: Text('$Player1'),
                              onPressed: (){
                                answerSubmit();
                                print(answerClear);
                                print(selectCount);
                              },
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              child: Text('$Player1'),
                              onPressed: (){answerSubmit();},
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height : 100, width: 300,
                            child: ElevatedButton(
                              child: Text('$Player1'),
                              onPressed: (){answerSubmit();},
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