/*
 * @Descripttion: 
 * @version: 
 * @Author: Stick
 * @Date: 2019-07-24 19:00:07
 * @LastEditors: Stick
 * @LastEditTime: 2019-07-27 00:02:07
 */

import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list) {
    childIndex = 0;
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

  // 改变子类索引
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}
