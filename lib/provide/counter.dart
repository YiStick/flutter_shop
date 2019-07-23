/*
 * @Descripttion: 计算属性状态管理
 * @version: 
 * @Author: Stick
 * @Date: 2019-07-23 22:49:33
 * @LastEditors: Stick
 * @LastEditTime: 2019-07-23 22:53:59
 */
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int value = 0;
  increment() {
    value++;
    notifyListeners(); // 通知
  }
}
