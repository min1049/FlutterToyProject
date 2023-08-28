import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../models/url.dart';

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

class HttpServer{
  String _API_PREFIX = "http://112.154.223.218:7999/Room";

  Future<http.Response?> testGetReq() async {
      final response = await http.get(Uri.parse("$_API_PREFIX/"));
      if (response.statusCode == 200) {
        print("통신 가능");
        print(response.body);
          return response;
      } else {
        print("통신 불가");
          return null;
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
    Future<void> postCreateRoom(String room, String usrName,{bool executeWithArbitraryValue = false}) async{
      //var formData = FormData.fromMap({"roomNumber" : room, "NickName" : usrName});
      if(executeWithArbitraryValue){
        return;
      }
      else{
        Response response;
        Dio dio = new Dio();
        response = await dio.post("$_API_PREFIX/CreateRoom", data: {"roomNumber" : room, "NickName" : usrName},);
        print("여기야 $response");
      }
    }
    Future<List<String>> postGetName(String room, {bool executeWithArbitraryValue = false}) async {
      if(executeWithArbitraryValue){
        // 임의의 값으로 로직 실행
        List<String> responseData = ["P1","P2","P3","P4"];
        return responseData;
      }
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/GetParticipation", data: {"roomNumber" : room},);
      dynamic responseBody = response.data;
        if(response.statusCode == 200){

          //List<dynamic> jsonList = json.decode(response.data);
          //("json data: $jsonList");
          //List<String> responseData = List<String>.from(response.data);
          List<dynamic> responseData = responseBody.map((item) => item.toString()).toList();
          List<String> stringData = responseData.map((dynamic item) => item.toString()).toList();
          //List<String> responseData = List<String>.from(response.data);
          print("response.data 타입 : ${response.data.runtimeType}");
          print("참여자 이름 : ${responseData}");
          return stringData;
        }
        else{
          print("연결되지 않음");
          List<String> responseData = ["영민"];
          return responseData;
        }
    }
    Future<void> postParticipateRoom(String room, String usrName) async{
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/ParticipateRoom", data: {"roomNumber" : room, "NickName" : usrName},);
    }
    Future<void> exitRoom(String room, String usrName) async{
      Dio dio = new Dio();
      dio.post("$_API_PREFIX/Exit", data: {"roomNumber" : room,"NickName" : usrName}, );
    }
    Future<void> postAnswer(String answer) async{
      Response response;
      Dio dio = new Dio();
      String room = "1234";
      String usrName = "영민";
      response = await dio.post("$_API_PREFIX/CompleteAnswer",data : {"roomNumber" : room, "NickName" : usrName, "Answer" : answer});
    }


    Future<List<String>> postGetAnswer(String room, int round, {bool executeWithArbitraryValue = false }) async{
      if (executeWithArbitraryValue) {
        // 임의의 값으로 로직 실행
        List<String> responseData = ["답1", "답2", "답3"];
        return responseData;
      }
      Response response;
      Dio dio = new Dio();
      response = await dio.post("$_API_PREFIX/GetAnswers",data: {"roomNumber" : room, "gameRepeatCount" : round}).timeout(Duration(seconds: 2));
      try{
        if(response.statusCode == 200){
          //List<String> responseData = List<String>.from(response.data.map((dynamic item) => item.toString()));
          List<String> responseData = List<String>.from(response.data);
          print("정답들 : ${response.data}");
          return responseData;
        }
        else{
          List<String> responseData = ["1","2","3"];
          return responseData;
        }
      }
      catch(e){
        print("오류 $e");
        return [];
      }
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

  Future<void> postGameStart({required room_id, round = 1}) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/GameStart",data: {"roomNumber" : room_id, "gameRepeatCount" : round});
    return;
  }

  Future<String> postGetIt({required room_id}) async{
    Response response;
    Dio dio = new Dio();

    response = await dio.post("$_API_PREFIX/GetIt", data: {"roomNumber" : room_id });

    print("술래 : ${response.data}");
    return response.data;
  }

  void postGuessPerson({required room_id, required picker, required targer_usr, required answer}){
    Dio dio = new Dio();

    dio.post("$_API_PREFIX/GuessPerson", data: {"roomNumber" : room_id ,"NickName" : picker,"selectNickName" : targer_usr, "selectAnswer" : answer});
  }

  Future<String> postResult({required room_id, required picker}) async {
    Response response;
    Dio dio = new Dio();

    response = await dio.post("$_API_PREFIX/Result", data: {"roomNumber" : room_id, "NickName" : picker });

    return response.toString();
  }
}




HttpServer server = HttpServer();