import "package:flutter/material.dart";
import "package:untitled2/make_room.dart";

class ScreenResult extends StatelessWidget{
  int correct_num = 3;
  ScreenResult({ Key? key }) : super(key: key){
    //생성자를 통해서 데이터를 받아와서 해당 갯수 만큼 correct_num에 할당 할 것
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