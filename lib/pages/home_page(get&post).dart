import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您来到美好人间高级会所';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('美好人间'),
          ),
          body: SingleChildScrollView( // 在某些机器上键盘弹起后会对部分元素遮挡，采用这个方式能够得到解决；在课程视频上是遮挡了的，但是我实际使用虚拟机，安卓9没有遮挡问题；真机魅族note6，安卓7.1也没这个问题
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: typeController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: '美女类型',
                        helperText: '请输入你喜欢的类型'),
                    autofocus: false, // 防止自动打开键盘，会影响页面布局
                  ),
                  RaisedButton(
                    onPressed: _choiceAction, // 方法调用
                    child: Text('选择完毕'),
                  ),
                  Text(
                    // 单独使用该组件要进行属性限制达到兼容
                    showText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型**********');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('美女类型为空'),
              ));
    } else {
      // 调用请求方法
      /* getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      }); */
      postHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      response = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  Future postHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      response = await Dio().post(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian",
          queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
