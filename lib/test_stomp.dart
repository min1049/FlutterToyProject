
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class TestStompPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STOMP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StompClient stompClient;
  String message = '';

  @override
  void initState() {
    super.initState();

    // Define STOMP configuration
    final stompConfig = StompConfig(
      url: 'ws://your-stomp-server-url', // Replace with your STOMP server URL
      onConnect: (StompFrame connectFrame) {
        print('Connected to STOMP server');

        // Subscribe to a topic
        stompClient.subscribe(
          destination: '/topic/example',
          callback: (StompFrame frame) {
            setState(() {
              message = frame.body!;
            });
          },
        );
      },
    );

    // Initialize STOMP client
    stompClient = StompClient(config: stompConfig);
    stompClient.activate();
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STOMP Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Received Message:',
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
