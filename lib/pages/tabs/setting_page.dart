import 'package:flutter/material.dart';
import 'package:flutter_application_demo/pages/under_construction_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const UnderConstructionPage();
  }
}
