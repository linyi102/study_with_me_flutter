import 'package:flutter/material.dart';
import 'package:flutter_application_demo/tabs/tabs.dart';
import 'package:flutter_application_demo/pages/under_construction_page.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("forum_page：访问论坛，关闭indexChannel");
    indexChannel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "论坛",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const UnderConstructionPage());
  }
}
