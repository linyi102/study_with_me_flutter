import 'package:flutter/material.dart';
import 'package:flutter_application_demo/components/fade_route.dart';
import 'package:flutter_application_demo/tabs/tabs.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          FadeRoute(
              builder: (context) => const Tabs(),
              transitionDuration: const Duration(milliseconds: 500)),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: Image.asset(
        // "assets/images/bgStart.jpg",
        "assets/images/start.gif",
        fit: BoxFit.cover,
      ),
      constraints: const BoxConstraints.expand(),
    );
  }
}
