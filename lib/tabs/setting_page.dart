import 'package:flutter/material.dart';
import 'package:flutter_application_demo/tabs/tabs.dart';
import 'package:flutter_application_demo/pages/under_construction_page.dart';

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
    return const UnderConstructionPage();
  }
}
