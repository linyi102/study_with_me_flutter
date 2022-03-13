import 'package:flutter/services.dart'; // fim: (f)lutter,(im)port
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/tabs/loading_page.dart';

const roomWebSocketUrl =
    "ws://8.141.147.248:8080/study_with_me/room_web_socket";
const indexWebSocketUrl =
    "ws://8.141.147.248:8080/study_with_me/index_web_socket";

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
      title: "Study With Me",
      debugShowCheckedModeBanner: false,
      // scaffold(脚手架)，通过脚手架实现home
      // home: const Tabs(),
      home: const LoadingPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: const AppBarTheme(
          // 统一设置AppBar主题
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
