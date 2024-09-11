import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodtimer/entity/food_bean.dart';
import 'package:get/get.dart';

import '../../db/db_service.dart';

class LLHomeLogic extends GetxController {
  static LLHomeLogic get to => Get.find<LLHomeLogic>();
  final db = Get.find<DatabaseService>();
  List<FoodBean> list = <FoodBean>[];
  int tabIndex = 0;

  @override
  onInit() {
    super.onInit();
    initDate();
  }

  initDate() async {
    getList(0);
  }

  getList(int index) async {
    tabIndex = index;
    EasyLoading.show();
    list = await db.getFoodsByTabIndex(index);
    EasyLoading.dismiss();
    update();
  }

  void clear() {
    list.clear();
    update();
  }

  listUpdate() async {
    await getList(tabIndex);
    update();
  }
}
