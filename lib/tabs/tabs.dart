import 'package:flutter/material.dart';
import 'package:flutter_application_demo/tabs/forum_page.dart';
import 'package:flutter_application_demo/tabs/home_page.dart';
import 'package:flutter_application_demo/tabs/setting_page.dart';
import 'package:web_socket_channel/io.dart';

import '../main.dart';

IOWebSocketChannel indexChannel = IOWebSocketChannel.connect(indexWebSocketUrl);

// 15 Flutter BottomNavigationBar 自定义底部导航条、以及实现页面切换
class Tabs extends StatefulWidget {
  final int currentIndex;
  const Tabs({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TabsState createState() => _TabsState(currentIndex);
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List _pageList = [
    const HomePage(),
    const ForumPage(),
    const SettingPage(),
  ];

  _TabsState(int currentIndex) {
    _currentIndex = currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Study With Me",
      //     style: TextStyle(
      //       color: Colors.black,
      //       letterSpacing: 2,
      //       // fontFamily: 'times',
      //       // fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   shadowColor: Colors.transparent,
      //   elevation: 0,
      //   // elevation: 1,
      //   backgroundColor: Colors.white,
      // ),
      // body: const HomePage(),
      body: _pageList[_currentIndex],
      // 底部导航栏，根据选择的项动态改变dody里的内容，从而实现跳转页面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // 当单击某个底部导航栏的某一项时，会传入该项的索引到onTap中
        onTap: (int index) {
          setState(() {
            // 改变状态，所有用到了_currentIndex的组件都会重新加载，如body和currentIndex
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue, // 选中某一项的颜色，或者用fixedColor
        backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.forum_rounded), label: "论坛"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
