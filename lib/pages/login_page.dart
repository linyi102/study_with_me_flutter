import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "登录账户",
        style: TextStyle(color: Colors.black),
      )),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle_outlined),
                labelText: "账户名",
                border: OutlineInputBorder(
                  // 设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: "密码",
                border: OutlineInputBorder(
                  // 设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // borderSide: BorderSide(color: Colors.blue, width: 5),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.check))
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("注册"),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("登录"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
