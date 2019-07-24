/*
 * @Descripttion: 
 * @version: 
 * @Author: Stick
 * @Date: 2019-07-24 19:00:07
 * @LastEditors: Stick
 * @LastEditTime: 2019-07-24 19:10:19
 */

import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List list) {
    childCategoryList = list;
    notifyListeners(); // 监听方法
  }
}
