/*
 * @Descripttion: 数据处理,构建数据模型
 * @version: test
 * @Author: Stick
 * @Date: 2019-07-21 17:03:03
 * @LastEditors: Stick
 * @LastEditTime: 2019-07-21 17:37:50
 */

class CategoryBigModel {
  String mallCategoryId; // 类别编号
  String mallCategoryName; // 类别名称
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryBigModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  // 工厂函数
  factory CategoryBigModel.fromJson(dynamic json) {
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;

  CategoryBigListModel(this.data);

  factory CategoryBigListModel.fromJson(List json) {
    return CategoryBigListModel(
        json.map((i) => CategoryBigModel.fromJson((i))).toList());
  }
}
