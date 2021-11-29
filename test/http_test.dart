import 'package:dio/dio.dart';

void getHttp() async {
  try {
    var response = await Dio().get('https://www.baidu.com/');
    print(response);
  } catch (e) {
    print(e);
  }
}

main(List<String> args) {
  getHttp();
  print("hello");
}
