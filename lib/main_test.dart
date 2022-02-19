import 'package:flutter/services.dart'; // fim: (f)lutter,(im)port
import 'package:flutter/material.dart';
import 'res/list_data.dart';
import 'tabs/tabs.dart';

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

// 14 Flutter StatefulWidget有状态组件 、页面上绑定数据、改变页面数据 、实现计数器功能 动态列表
class HomeContentP29 extends StatefulWidget {
  const HomeContentP29({Key? key}) : super(key: key);

  @override
  _HomeContentP29State createState() => _HomeContentP29State();
}

class _HomeContentP29State extends State<HomeContentP29> {
  int cnt = 0;
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            children: [
              Text("$cnt"),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cnt++;
                  });
                },
                child: const Text("click"),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        list.add("新增数据");
                      });
                    },
                    child: const Text("add"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        list.clear();
                      });
                    },
                    child: const Text("clear"),
                  ),
                ],
              ),
              Column(
                children: list.map((e) {
                  return ListTile(
                    title: Text(
                      e,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// 13 Flutter 页面布局 Wrap组件
class HomeContentP28 extends StatelessWidget {
  const HomeContentP28({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyButton("进入");
  }
}

class MyButton extends StatelessWidget {
  final String content;
  const MyButton(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(content),
    );
  }
}

// 12 Flutter 页面布局 Flutter AspectRatio、Card卡片组件、卡片图文列表

// 11 Flutter 页面布局 Stack层叠组件 Stack与Align  Stack与Positioned实现定位布局
class HomeContentP26 extends StatelessWidget {
  const HomeContentP26({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        const Text("data11111"),
        Container(
          height: 400,
          width: 200,
          color: Colors.blue,
        ),
        const Text(
          "data22222222222",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
              "22222222"), // 因为Stack只是用来放层叠的，所以这些元素的容器仍是整个手机界面，所以会在手机中心，而非在Contatiner中间(和他只是层叠关系)
        )
      ],
    );
  }
}

// 10 Flutter 页面布局 Paddiing Row Column Expanded组件详解
class HomeContentP25 extends StatelessWidget {
  const HomeContentP25({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Expanded(
          child: IconContainer(
            Icons.ac_unit,
            size: 50,
            bgcolor: Colors.blue,
          ),
        ),
        Expanded(
          child: IconContainer(
            Icons.favorite,
            size: 50,
            bgcolor: Colors.orange,
          ),
        ),
        Expanded(
          child: IconContainer(
            Icons.alarm,
            size: 50,
            bgcolor: Colors.green,
          ),
        ),
      ],
      // children: [
      //   IconContainer(
      //     Icons.ac_unit,
      //     size: 50,
      //     bgcolor: Colors.blue,
      //   ),
      //   IconContainer(
      //     Icons.favorite,
      //     size: 50,
      //     bgcolor: Colors.orange,
      //   ),
      //   IconContainer(
      //     Icons.alarm,
      //     size: 50,
      //     bgcolor: Colors.green,
      //   )
      // ],
    );
  }
}

// 自定义图标组件，因为Flutter的图标组件没有背景颜色
class IconContainer extends StatelessWidget {
  final IconData icon; //图标样式
  final double size; //图标大小
  final Color bgcolor; // 容器背景色
  const IconContainer(this.icon,
      {Key? key, this.size = 32, this.bgcolor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: bgcolor,
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

// 09 Flutter GridView组件 以及动态GridView
class HomeContentP24 extends StatelessWidget {
  const HomeContentP24({Key? key}) : super(key: key);

  List<Widget> _getListDataByMap() {
    var tempList = listData.map((value) {
      return Container(
        child: ListView(
          children: [
            Image.network(
              value["imageUrl"], // value["imageUrl"]得到值，也就是字符串
            ),
            // 避免图片和文本紧挨，一般用SizedBox填充空白
            const SizedBox(
              height: 10,
            ),
            Text(
              value["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: Colors.amber.shade100,
            width: 5,
          ),
        ),
      );
    });
    // map后得到的数据是：('xxx', 'xxx')，不是List，所以需要转换
    return tempList.toList();
  }

  List<Widget> _getListData() {
    List<Widget> list = [];
    for (var i = 0; i < 20; ++i) {
      list.add(Container(
        child: Text(
          "第$i条数据",
          style: const TextStyle(color: Colors.black),
        ),
        alignment: Alignment.center,
        color: Colors.lightBlue,
        // height: 200, // 在这里设置高度无效
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 4, // 孩子间的横轴间距
      mainAxisSpacing: 4, // 孩子间的主轴间距
      padding: const EdgeInsets.all(4),
      crossAxisCount: 2, // 横轴的孩子数量
      // childAspectRatio: 1.5, //调整孩子的宽:高比例为15:10
      children: _getListDataByMap(),
    );
  }
}

// 08 Flutter ListView动态列表组件 以及循环动态数据
class HomeContentP23 extends StatelessWidget {
  const HomeContentP23({Key? key}) : super(key: key);

  // 动态列表就是循环遍历，减少代码重复度
  // 自定义方法，_标记为私有方法，只允许该类调用
  List<Widget> _getData() {
    // error: List<Widget> list = List.empty();
    // 原因：list = List.empty(); //用于清空列表
    List<Widget> list = [];
    for (var i = 0; i < 20; ++i) {
      list.add(ListTile(
        title: Text("我是第$i个列表"),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getData(),
    );
  }
}

// 07 Flutter ListView基础列表组件、水平列表组件、图标组件
class HomeContentP22 extends StatelessWidget {
  const HomeContentP22({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10),
      // children(孩子们)
      children: [
        const ListTile(
          title: Text("嘘！你听"),
          subtitle: Text("男子违停用卫生纸挡号牌被抓现行 交警：罚款 200 元，记 12 分"),
        ),
        const ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          title: Text("爱好"),
        ),
        ListTile(
          leading: Image.network(
              "https://n.sinaimg.cn/news/transform/195/w105h90/20211104/0824-17423330ff24b55871066e9d48b0f4e4.jpg"),
          title: const Text("新浪资讯台"),
          subtitle: const Text("近海利刃！直击海上实弹射击超燃场面 主炮射速达每分钟百发"),
        ),
        Image.network(
          "https://img11.360buyimg.com/ddimg/jfs/t1/140520/24/22012/439517/6184a0b4Efd82b097/04cb13c9e9d26091.png",
        ),
      ],
    );
  }
}

// 06 Flutter 图片组件Image 、本地图片、远程图片、图片剪切
class HomeContentP21 extends StatelessWidget {
  const HomeContentP21({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 注：可以直接返回图片，不用放在容器中，因为他们的根类都是Widget
    return Center(
      child: Container(
        // height: 300,
        // width: 300,

        // 把图片(Image)作为孩子(child)，而不是把文本(Text)作为孩子
        // 不过注意这种方式设置图片时，容器设置为圆角并不会影响图片，若想则需要在容器的装饰中添加图片
        // child: Image.network(
        //   "https://img11.360buyimg.com/ddimg/jfs/t1/140520/24/22012/439517/6184a0b4Efd82b097/04cb13c9e9d26091.png",
        //   // 指定图片在容器中的位置
        //   alignment: Alignment.topLeft,
        //   // fill和cover都会填满容器，fill会拉伸图片，而cover会裁剪
        //   fit: BoxFit.fill,
        // ),

        // decoration: BoxDecoration(
        //   color: Colors.amber,
        //   // 实现圆形图片方式1：利用容器的装饰
        //   // 150是边长为300的容器的一半，因此是圆形
        //   borderRadius: BorderRadius.circular(300),
        //   image: const DecorationImage(
        //     image: NetworkImage(
        //       "https://img11.360buyimg.com/ddimg/jfs/t1/140520/24/22012/439517/6184a0b4Efd82b097/04cb13c9e9d26091.png",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),

        // 实现圆形图片方式2
        child: ClipOval(
          child: Image.network(
            "https://img14.360buyimg.com/ddimg/jfs/t1/89219/10/19718/331710/6184a473E86b139df/c6852c3bd8a264a2.png",
            // "https://img11.360buyimg.com/ddimg/jfs/t1/140520/24/22012/439517/6184a0b4Efd82b097/04cb13c9e9d26091.png",
            width: 300,
            // height: 200,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// 05 Flutter Container组件、Text组件详解
class HomeContentP20 extends StatelessWidget {
  const HomeContentP20({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // Container类似div，可以设置宽度、高度、背景颜色
      child: Container(
        child: const Text(
          "文本\ntexttexttexttexttexttexttexttexttexttext",
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.purple,
            letterSpacing: 5.0,
          ),
        ),
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(
            color: Colors.blue,
            width: 4.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        // padding: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        alignment: Alignment.bottomLeft,
      ),
    );
  }
}

// 04 Flutter目录结构介绍、入口、自定义Widget、Center组件、Text组件、MaterialApp组件、Scaffold组件
// 自定义组件：首页内容
class HomeContentP19 extends StatelessWidget {
  const HomeContentP19({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "你好，flutter",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 40.0,
          // color: Color.fromRGBO(244, 234, 5, 0.5)
          color: Colors.blue,
        ),
      ),
    );
  }
}
