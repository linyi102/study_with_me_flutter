import 'package:flutter/material.dart';
import 'package:flutter_application_demo/pages/tabs.dart';

class Room extends StatefulWidget {
  final int roomId;

  const Room(this.roomId, {Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自习室 " + widget.roomId.toString()), // 通过widget获取状态组件的成员变量
        centerTitle: true,
      ),
      body: BodyContent(),
    );
  }
}

// ignore: must_be_immutable
class BodyContent extends StatefulWidget {
  int roomPeopleCnt = 0;
  BodyContent({Key? key}) : super(key: key);

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "目前人数：${widget.roomPeopleCnt}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.roomPeopleCnt++;
              });
            },
            child: const Text("更新人数"),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Tabs()),
                  (route) => false);
            },
            child: const Text("退出自习室"),
          ),
        ],
      ),
    );
  }
}
