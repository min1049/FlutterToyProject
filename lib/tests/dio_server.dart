import 'dart:async';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

/*
class Services{
  static const String url = 'http://10.14.4.78:8080/Room/';

  static Future<List<User>> getInfo() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<User> user = userFromJson(response.body);
        return user;
      } else {
        Fluttertoast.showToast(msg: 'Error occured. Please try again');
        return <User>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return <User>[];
    }
  }
}
*/

class Server{
  String _API_PREFIX = "http://10.14.4.78:8080/Room";

  Future<dynamic> testGetReq() async {
    try {
      final response = await http.get(Uri.parse("$_API_PREFIX/"));
      if (response.statusCode == 200) {
        print("통신 가능");
        print(response.body);
        return response;
      } else {
        print("통신 불가");
      }
    } catch (e) {
        print("에러 발생");
    }
  }
  Future<void> getReq() async {
    // async 끝났다라는 신호
    Response response;
    Dio dio = new Dio();

    response = await dio.get("$_API_PREFIX");
    //print(response.data.toString());
  }
    Future<void> postReq() async {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(_API_PREFIX, data: {});
      print(response.data.toString());
    }
    Future<void> postCreateRoom(String room, String usrName) async{
      //var formData = FormData.fromMap({"roomNumber" : room, "NickName" : usrName});
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/CreateRoom", data: {"roomNumber" : room, "NickName" : usrName},);
      //print("여기야 $response");
    }
    Future<List<String>> postGetName(String room) async {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/GetParticipation", data: {"roomNumber" : room},);
      List<String> responseData = List<String>.from(response.data.map((dynamic item) => item.toString()));
      return responseData;
    }
    Future<void> postParticipateRoom(String room, String usrName) async{
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/ParticipateRoom", data: {"roomNumber" : room, "NickName" : usrName},);
    }
    Future<void> postAnswer(String answer) async{
      Response response;
      Dio dio = new Dio();
      String room = "1234";
      String usrName = "영민";
      response = await dio.post("$_API_PREFIX/CompleteAnswer",data : {"roomNumber" : room, "NickName" : usrName, "Answer" : answer});
    }
    Future<List<String>> postGetAnswer(String room, int round) async{
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/GetAnswers",data: {"roomNumber" : room, "gameRepeatCount" : round});
      List<String> responseData = List<String>.from(response.data.map((dynamic item) => item.toString()));
      print(response);
      return responseData;
    }
    Future<List<String>> postGetName2(String room, int round) async{
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/GetAnswers",data: {"roomNumber" : room, "gameRepeatCount" : round});
    List<String> responseData = List<String>.from(response.data.map((dynamic item) => item.toString()));
    print(response);
    return responseData;
    }

    Future<void> post_usr_name_req(dynamic usrname) async{
      Response response;
      Dio dio = new Dio();
      response = await dio.post(_API_PREFIX, data: {"id" : usrname} );
    }

    Future<void> getReqWzQuery() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(_API_PREFIX, queryParameters: { });
  }
}



Server server = Server();