import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/pages/tabs.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Room extends StatefulWidget {
  final int roomId;

  const Room(this.roomId, {Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  int roomPeopleCnt = 0;
  var channel = IOWebSocketChannel.connect(
      "ws://njtg5y.natappfree.cc/study_with_me/room_web_socket");
  @override
  void initState() {
    super.initState();
    Map info = {
      "action": "enter",
      "roomId": widget.roomId,
    };
    channel.sink.add(json.encode(info));
    channel.stream.listen((event) {
      setState(() {
        roomPeopleCnt = int.parse(event);
      });
    });
  }

  Future<bool> _leaveRoom() {
    Map info = {
      "action": "leave",
      "roomId": widget.roomId,
    };
    channel.sink.add(json.encode(info));
    channel.sink.close();
    Navigator.of(context).pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _leaveRoom,
      child: Scaffold(
        appBar: AppBar(
          title: Text("自习室 " + widget.roomId.toString()), // 通过widget获取状态组件的成员变量
          centerTitle: true,
          automaticallyImplyLeading: false, // 隐藏自带的返回按钮
          leading: IconButton(
            onPressed: () {
              Map info = {
                "action": "leave",
                "roomId": widget.roomId,
              };
              channel.sink.add(json.encode(info));
              channel.sink.close();
              Navigator.of(context).pop();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const Tabs()),
              //     (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_outline_sharp,
                  ),
                  Text(
                    "$roomPeopleCnt",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Map info = {
              //       "action": "leave",
              //       "roomId": widget.roomId,
              //     };
              //     channel.sink.add(json.encode(info));
              //     channel.sink.close();
              //     // Navigator.of(context).pop();
              //     Navigator.of(context).pushAndRemoveUntil(
              //         MaterialPageRoute(builder: (context) => const Tabs()),
              //         (route) => false);
              //   },
              //   child: const Text("退出自习室"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
