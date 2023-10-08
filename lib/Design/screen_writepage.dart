import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:untitled2/Design/screen_resultpage.dart";
import "package:untitled2/screen_result.dart";
import "package:untitled2/tests/dio_server.dart";

class DesignedWritePage extends StatefulWidget {
  HttpServer server = HttpServer();
  var picker;
  var topic;

  late Map<String, dynamic> room_information;


  DesignedWritePage({ Key? key, required this.room_information}){
    print("room_information in DesignedWritePage page : \n $room_information \n");
    fetchTopic();
    this.picker = room_information["picker"];
  }
  void fetchTopic() async {
    this.topic = await server.postRequestQuestion(room_id: room_information["room_id"]);
  }

  @override
  State<StatefulWidget> createState() {
    return DesignedWritePageForm(room_information: room_information);
  }
}


class DesignedWritePageForm extends State<DesignedWritePage> {
  var answer = "";

  bool submitAnswer = false;


  var room_information;

  DesignedWritePageForm({ Key? key, required this.room_information}) {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin : EdgeInsets.only(right: 20, left: 20),
          child: Center(
              child: submitAnswer
                  ? ScreenWaiting()
                  : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("술래는\n ${widget.picker} \n${widget.topic}",
                      style: TextStyle(fontSize: 42),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              onChanged: (text) {
                                answer = text;
                              },
                              decoration:
                              InputDecoration.collapsed(hintText: "답변을 작성해주세요",floatingLabelAlignment: FloatingLabelAlignment.center),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Theme
                                .of(context)
                                .platform == TargetPlatform.iOS
                                ? CupertinoButton(
                                child: Text("send"),
                                onPressed: () {
                                }
                            )
                                : IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  //server.postCompleteAnwser(room_id: room_information["room_id"], usr_id: room_information["usr_name"], text: answer);
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('입력완료'),
                              onPressed: () {
                                setState(() {
                                  submitAnswer = true;

                                });
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        )
                    ),
                  ]
              )
          ),
        )
    );
  }
}

class ScreenWaiting extends StatelessWidget {
  ScreenWaiting({ Key? key }) : super(key: key);

  bool submitAnswerAll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: submitAnswerAll?
                ScreenWaitingSubmitAnswer():
                ScreenWaitingSubmitAnswerAll()
        )
    );
  }
}

class ScreenWaitingSubmitAnswer extends StatelessWidget{
  const ScreenWaitingSubmitAnswer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('유저가 다 입력할 때 까지 기다려주십시오...',
                  style: TextStyle(fontSize: 42),
                  textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:
                        ElevatedButton(
                          child: const Text('모든 유저가 입력완료'),
                          onPressed: () {
                            
                          },
                        ),
                      ),
                      Container(
                        width: 25,
                      ),
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('돌아가기'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                      ),
                    ]
                )
              ],
            );
  }
}

class ScreenWaitingSubmitAnswerAll extends StatelessWidget {
  const ScreenWaitingSubmitAnswerAll({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('술래가 작성자를 \n유추중입니다...',
                  style: TextStyle(fontSize: 42),
                  textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('술래가 정답을 선택 완료'),
                            onPressed: () {
                              /*
                              Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => DesignedResultPage(room_information: room_informaion, result: result)),);

                               */
                            },
                          )
                      ),
                      Container(
                        width: 25,
                      ),
                      Container(
                          child:
                          ElevatedButton(
                            child: const Text('돌아가기'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
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