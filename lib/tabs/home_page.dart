import 'package:flutter/material.dart';
import 'package:flutter_application_demo/components/fade_route.dart';
import 'package:flutter_application_demo/main.dart';
import 'package:flutter_application_demo/pages/room_page.dart';
import 'package:flutter_application_demo/tabs/tabs.dart';
import 'package:web_socket_channel/io.dart';

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
    _listenIndexChannel();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _displayRoomCards(),
    );
  }

  void modifyAllRoomPeopleCnt(Map map) {
    setState(() {
      _allRoomPeopleCnt = map;
    });
  }

  void _listenIndexChannel() {
    indexChannel.sink.close();
    debugPrint("home_page：连接并监听indexChannel");
    indexChannel = IOWebSocketChannel.connect(indexWebSocketUrl);
    List list = [];
    indexChannel.stream.listen((event) {
      list = event.toString().split(" ");
      debugPrint("list: ${list.toString()}");
      Map map = {
        "room1": int.parse(list[1]),
        "room2": int.parse(list[2]),
        "room3": int.parse(list[3]),
        "room4": int.parse(list[4]),
      };
      modifyAllRoomPeopleCnt(map);
    });
  }

  _displayRoomCards() {
    final List bgUrl = [
      "", // 自习室id从1开始，因此0索引没用到
      "assets/images/bg1.png",
      "assets/images/bg2.png",
      "assets/images/bg3.png",
      "assets/images/bg7.png",
      "assets/images/bg5.png",
      "assets/images/bg5.png",
      "assets/images/bg5.png",
    ];

    // final List<Color> bgColor = [
    //   Colors.black,
    //   Colors.blueGrey.withOpacity(0.8),
    //   Colors.orange.withOpacity(0.8),
    //   Colors.black.withOpacity(0.8),
    //   Colors.green.withOpacity(0.8),
    //   Colors.blueGrey.withOpacity(0.8),
    //   Colors.orange.withOpacity(0.8),
    // ];

    List<Widget> cards = [];
    for (int roomId = 1; roomId < 5; ++roomId) {
      int roomPeopleCnt = _allRoomPeopleCnt["room$roomId"];
      cards.add(Card(
        // margin: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        elevation: 10, // z轴高度，即阴影大小
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))), // 圆角
        clipBehavior: Clip.antiAlias, // 设置抗锯齿，实现圆角背景
        child: AspectRatio(
          // 宽高比
          aspectRatio: 16 / 7,
          child: Stack(
            children: [
              // 纯色背景
              // Container(
              //   // color: Colors.blueGrey,
              //   color: widget._bgColor[widget._roomId],
              // ),
              // 最底层是图片，外面嵌套ConstrainedBox，给Image加约束，让它填充父布局
              MaterialButton(
                padding: const EdgeInsets.all(0),
                focusColor: Colors.transparent,
                onPressed: () {
                  debugPrint("home_page：离开主页，进入自习室$roomId，关闭indexChannel");
                  indexChannel.sink.close();
                  // 按下按钮，触发路由跳转
                  Navigator.of(context).push(
                    FadeRoute(builder: (context) {
                      return Room(roomId);
                    }),
                  ).then((value) {
                    debugPrint("home_page：从自习室返回主页");
                    _listenIndexChannel();
                  });
                },
                child: ConstrainedBox(
                  child: Image.asset(
                    bgUrl[roomId],
                    fit: BoxFit.cover,
                  ),
                  constraints: const BoxConstraints.expand(),
                ),
              ),
              // Align的child若指定Row，则无法定位，而Positioned可以
              Positioned(
                left: 10,
                top: 10,
                child: Text(
                  "自习室 $roomId",
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
                      "$roomPeopleCnt",
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
      ));
    }
    return cards;
  }
}
