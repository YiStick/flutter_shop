import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
              // 数据处理
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper =
                  (data['data']['slides'] as List).cast(); // 顶部轮播组件数
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicUrl =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];

              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper //页面顶部轮播组件
                      ),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicUrl),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone)
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
    /* print('设备的像素密度：${ScreenUtil.pixelRatio}');
    print('设备的屏幕的高度：${ScreenUtil.screenHeight}');
    print('设备的屏幕的宽度：${ScreenUtil.screenWidth}'); */
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

// 轮播下方导航栏部分
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(adPicture));
  }
}

// 店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长图片
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: _launchURL,
      child: Image.network(leaderImage),
    ));
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    // String url = 'http://jspang.com';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问，异常';
    }
  }
}
