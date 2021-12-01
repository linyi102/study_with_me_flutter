import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/main.dart';
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
  var roomChannel = IOWebSocketChannel.connect(roomWebSocketUrl);
  @override
  void initState() {
    debugPrint("room：访问自习室，打开roomChannel");
    super.initState();
    Map info = {
      "action": "enter",
      "roomId": widget.roomId,
    };
    roomChannel.sink.add(json.encode(info));
    roomChannel.stream.listen((event) {
      setState(() {
        roomPeopleCnt = int.parse(event);
      });
    });
  }

  Future<bool> _leaveRoom() {
    // 返回前需要手动关闭WebSocket
    debugPrint("room：离开自习室，关闭roomChannel，同时打开indexChannel");
    roomChannel.sink.close();
    indexChannel = IOWebSocketChannel.connect(indexWebSocketUrl);
    Navigator.of(context).pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _leaveRoom,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "自习室 " + widget.roomId.toString(),
            style: const TextStyle(color: Colors.black),
          ), // 通过widget获取状态组件的成员变量
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, // 隐藏自带的返回按钮
          leading: IconButton(
            onPressed: () {
              _leaveRoom();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
