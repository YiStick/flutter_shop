/*
 * @Descripttion: 
 * @version: 
 * @Author: Stick
 * @Date: 2019-07-24 19:00:07
 * @LastEditors: Stick
 * @LastEditTime: 2019-07-25 22:25:35
 */

import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
    // 声明一个all对象加到原数组前面
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners(); // 监听方法
  }
}
