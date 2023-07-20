import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

String _API_PREFIX = " ";

class Server{
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
      response = await dio.post(_API_PREFIX, data: { });
      //print(response.data.toString());
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