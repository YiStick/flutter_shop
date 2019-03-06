import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          // 动态渲染组件
          future: getHomePageContent(), // 异步方法
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
              return Column(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: swiper,//页面顶部轮播组件
                  )
                ],
              );
            } else {
              return Center(
                child: Text('加载中……'),
              );
            }
          }, // 异步方法进行时的操作,接收2个参数
        ));
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  // SwiperDiy({Key key,this.swiperDataList}):super(key:key);
  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备的像素密度：${ScreenUtil.pixelRatio}');
    print('设备的屏幕的高度：${ScreenUtil.screenHeight}');
    print('设备的屏幕的宽度：${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill, // 图片样式，充满整个容器
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
