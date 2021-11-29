import 'package:flutter/material.dart';
import 'package:flutter_application_demo/pages/under_construction_page.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return const UnderConstructionPage();
  }
}
