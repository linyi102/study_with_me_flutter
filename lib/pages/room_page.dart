import 'dart:convert';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/main.dart';
import 'package:web_socket_channel/io.dart';

class Room extends StatefulWidget {
  final int roomId;

  const Room(this.roomId, {Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  int roomPeopleCnt = 0;
  var roomChannel = IOWebSocketChannel.connect(roomWebSocketUrl);
  final CustomTimerController _timeController = CustomTimerController();

  @override
  void initState() {
    debugPrint("room_page：访问自习室${widget.roomId}，连接并监听roomChannel");
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

  Future<bool> _leaveRoom() async {
    // 返回前需要手动关闭WebSocket
    debugPrint("room_page：离开自习室${widget.roomId}，关闭roomChannel");
    roomChannel.sink.close();
    Navigator.of(context).pop();
    return true;
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
          elevation: 0,
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 80, 0),
              child: Transform.scale(
                scale: 1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.person_outline_sharp,
                    ),
                    Text(
                      "$roomPeopleCnt",
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: 200,
            //   height: 200,
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(200),
            //   ),
            //   child: Stack(
            //     children: [],
            //   ),
            // ),
            Column(
              children: [
                Expanded(child: Container()),
                CustomTimer(
                    controller: _timeController,
                    begin: const Duration(days: 0),
                    end: const Duration(days: 1),
                    builder: (time) {
                      return Text(
                          "${time.hours}:${time.minutes}:${time.seconds}",
                          style: const TextStyle(fontSize: 24.0));
                    },
                    onChangeState: (state) {
                      // This callback function runs when the timer state changes.
                      debugPrint("Current state: $state");
                    }),
                IconButton(
                  onPressed: () {
                    if (_timeController.state == CustomTimerState.counting) {
                      _timeController.pause();
                    } else {
                      _timeController.start();
                    }
                    setState(() {});
                  },
                  icon: _timeController.state == CustomTimerState.counting
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
                Expanded(child: Container()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
