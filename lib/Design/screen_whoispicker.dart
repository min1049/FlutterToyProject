import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Design/screen_targetpage.dart';
import 'package:untitled2/Design/screen_writepage.dart';

import '../tests/dio_server.dart';

class DesignedWhoisPickerPage extends StatefulWidget {
  late Map<String, dynamic> room_information;

  DesignedWhoisPickerPage({required this.room_information}) {
    print("room_information in who is picker page : \n $room_information \n");
  }

  @override
  State<StatefulWidget> createState() {
    return DesignedWhoisPickerPageForm();
  }
}

class DesignedWhoisPickerPageForm extends State<DesignedWhoisPickerPage> {
  late dynamic picker;

  @override
  void initState() {
    super.initState();
    FetchPicker();
  }

  void FetchPicker() async {
    picker = await server.postGetIt(room_id: widget.room_information["room_id"]);
    widget.room_information["picker"] = picker;
  }

  Future<String> fetchData() async {
    // Simulate fetching data from the server
    await Future.delayed(Duration(seconds: 2));
    return "Data from server";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent navigating back
        return true;
      },
      child: Scaffold(
        body: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading data"));
            } else {
              Timer(Duration(seconds: 5), () {
                if(widget.room_information["usr_name"] == picker){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)
                      => DesignedRoomPick(room_information: widget.room_information))
                  );
                } else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)
                    => DesignedWritePage(
                        room_information: widget.room_information))
                  );
                }
              });
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("술래는? \n ${picker}"),
                  ],
                ),
              );
            }
            },
        ),
      ),
    );
  }
}
