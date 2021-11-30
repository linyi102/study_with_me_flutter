import 'package:flutter/material.dart';
import 'package:flutter_application_demo/main.dart';
import 'package:flutter_application_demo/pages/room.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// 因为切换到其他底栏并不会关闭WebSocket，重新点击主页又会重复添加，所以改为刷新一次进行一次WebSocket连接
// 修改：作为全局变量放在tabs.dart，每次点击其他底部导航就会关闭WebSocket，点击首页就会开启websoc
class _HomePageState extends State<HomePage> {
  Map _allRoomPeopleCnt = {};

  // 初始化时调用该方法
  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 5; ++i) {
      _allRoomPeopleCnt["room$i"] = 0;
    }
    _getAllRoomPeopleCnt();
  }

  @override
  Widget build(BuildContext context) {
    // 还不知道怎么应用到Column的children中
    // List list = [];
    // for (int i = 1; i <= 4; ++i) {
    //   list.add(RoomItem(i, _allRoomPeopleCnt["room$i"]));
    // }
    return RefreshIndicator(
      onRefresh: _getAllRoomPeopleCnt,
      // 一个列表
      // 不知道为啥必须要放在ListView里才有刷新的样式
      child: ListView(
        children: [
          RoomCard(1, _allRoomPeopleCnt["room1"]),
          RoomCard(2, _allRoomPeopleCnt["room2"]),
          RoomCard(3, _allRoomPeopleCnt["room3"]),
          RoomCard(4, _allRoomPeopleCnt["room4"]),
          // 旧样式
          // Column(
          //   children: [
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height / 3,
          //     ),
          //     RoomItem(1, _allRoomPeopleCnt["room1"]),
          //     RoomItem(2, _allRoomPeopleCnt["room2"]),
          //     RoomItem(3, _allRoomPeopleCnt["room3"]),
          //     RoomItem(4, _allRoomPeopleCnt["room4"]),
          //   ],
          // ),
        ],
      ),
    );
  }

  Future<void> _getAllRoomPeopleCnt() async {
    // 刚点主页就获取人数，然后关闭，然后每次刷新执行一次
    channel = IOWebSocketChannel.connect(indexWebSocketUrl);
    // channel.sink.add("enter index page");
    List list = [];
    channel.stream.listen((event) {
      list = event.toString().split(" ");
      debugPrint("list: ${list.toString()}");

      Map map = {
        "room1": int.parse(list[1]),
        "room2": int.parse(list[2]),
        "room3": int.parse(list[3]),
        "room4": int.parse(list[4]),
      };
      setState(() {
        _allRoomPeopleCnt = map;
      });
    });
    // debugPrint("关闭WebSocket");
    // channel.sink.close();
  }
}

class RoomCard extends StatefulWidget {
  final int _roomId;
  final int _roomPeopleCnt;
  final List _bgUrl = [
    "", // 自习室id从1开始，因此0索引没用到
    "assets/images/bg1.png",
    "assets/images/bg2.png",
    "assets/images/bg3.png",
    "assets/images/bg7.png",
    "assets/images/bg5.png",
    "assets/images/bg5.png",
    "assets/images/bg5.png",
  ];

  final List<Color> _bgColor = [
    Colors.black,
    Colors.blueGrey.withOpacity(0.8),
    Colors.orange.withOpacity(0.8),
    Colors.black.withOpacity(0.8),
    Colors.green.withOpacity(0.8),
    Colors.blueGrey.withOpacity(0.8),
    Colors.orange.withOpacity(0.8),
  ];

  RoomCard(this._roomId, this._roomPeopleCnt, {Key? key}) : super(key: key);

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      focusColor: Colors.transparent,
      onPressed: () {
        // 按下按钮，触发路由跳转
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Room(widget._roomId),
          ),
        );
      },
      child: Card(
        // margin: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        elevation: 10, // z轴高度，即阴影大小
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))), // 圆角
        clipBehavior: Clip.antiAlias, // 设置抗锯齿，实现圆角背景
        child: AspectRatio(
          // 宽高比
          aspectRatio: 2 / 1,
          child: Stack(
            children: [
              // 纯色背景
              // Container(
              //   // color: Colors.blueGrey,
              //   color: widget._bgColor[widget._roomId],
              // ),
              // 最底层是图片，外面嵌套ConstrainedBox，给Image加约束，让它填充父布局
              ConstrainedBox(
                child: Image.asset(
                  widget._bgUrl[widget._roomId],
                  fit: BoxFit.cover,
                ),
                constraints: const BoxConstraints.expand(),
              ),
              // Align的child若指定Row，则无法定位，而Positioned可以
              Positioned(
                left: 10,
                top: 10,
                child: Text(
                  "自习室 ${widget._roomId}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                // top: 10,
                bottom: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline_sharp,
                      color: Colors.white,
                    ),
                    Text(
                      "${widget._roomPeopleCnt}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   right: 10,
              //   bottom: 10,
              //   child: EnterBottom(widget._roomId),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  final int roomId;
  int cnt = 0;

  RoomItem(this.roomId, this.cnt, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "自习室 " + roomId.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 20,
        ),
        EnterBottom(roomId),
        const SizedBox(
          width: 20,
        ),
        const Icon(Icons.person_outline_sharp),
        Text(
          "$cnt",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class EnterBottom extends StatefulWidget {
  final int roomId;

  const EnterBottom(this.roomId, {Key? key}) : super(key: key);

  @override
  State<EnterBottom> createState() => _EnterBottomState();
}

class _EnterBottomState extends State<EnterBottom> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 按下按钮，触发路由跳转
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Room(widget.roomId),
          ),
        );
      },
      child: const Text("进入"),
    );
  }
}
