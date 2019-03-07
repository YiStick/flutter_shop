import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主题内容
Future getHomePageContent() async {
  try {
    print('*****开始获取首页数据******');

    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");

    var formData = {'lon': '115.02932', 'lat': '35.76189'};

    response = await dio.post(servicePath['homePageContent'], data: formData);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

// 获得火爆专区的商品方法
Future getHomePageBeloConten() async {
  try {
    print('*****开始获取火爆专区数据******');

    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;

    response = await dio.post(servicePath['homePageBelowConten'], data: page);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

// 封装请求方法
Future request(url, formDadta) async {
  try {
    print('*****开始获取数据******');

    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formDadta == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formDadta);
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}
