import 'package:flutter/material.dart';
import 'package:flutter_application_demo/pages/login_page.dart';
import 'package:flutter_application_demo/tabs/tabs.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("setting_page：访问我的，关闭indexChannel");
    indexChannel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    // return const UnderConstructionPage();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "我的",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Transform.scale(
              scale: 4,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                hoverColor: Colors.transparent, // 悬停时的颜色
                highlightColor: Colors.transparent, // 长按时的颜色
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.person_rounded,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("更换主题"),
            onTap: () {},
            iconColor: Colors.blue,
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("学习记录"),
            onTap: () {},
            iconColor: Colors.blue,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("更多设置"),
            onTap: () {},
            iconColor: Colors.blue,
          ),
          ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text("关于版本"),
            onTap: () {},
            iconColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
