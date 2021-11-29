import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart'; // fim: (f)lutter,(im)port
import 'package:flutter/material.dart';
import 'res/list_data.dart';
import 'pages/tabs.dart';

// import 'dart:ffi';

void main() {
  // 顶部栏透明
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // 所有的组件都是类
  runApp(const MyApp());
}

// 自定义组件，需要继承StatelessWidget抽象类
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 推荐MaterialApp作为根组件
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // scaffold(脚手架)，通过脚手架实现home
      home: const Tabs(),
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
    );
  }
}
