import 'package:foodtimer/entity/food_bean.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../db/db_service.dart';
import '../../entity/stats_bean.dart';

class StatsLogic extends GetxController {
  static StatsLogic get to => Get.find<StatsLogic>();
  final db = Get.find<DatabaseService>();
  List<FoodBean> list = <FoodBean>[];
  final DateFormat formatterDay = DateFormat('yyyy-MM-dd');

  List<StatsBean> grList = [
    StatsBean("All", "0"),
    StatsBean("Active", "0"),
    StatsBean("Expired", "0"),
    StatsBean("Near Expired", "0"),
    StatsBean("Total Count", "0"),
    StatsBean("Total Price", "0"),
  ];
  List<StatsBean> typeList = [];

  @override
  onInit() {
    super.onInit();
    initDate();
  }

  initDate() async {
    getList();
  }



  getList() async {
    grList = await db.getAllStatsByDate();
    typeList = await db.getAllStatsByType();
    update();
  }

  void clear() {
    grList = [
      StatsBean("All", "0"),
      StatsBean("Active", "0"),
      StatsBean("Expired", "0"),
      StatsBean("Near Expired", "0"),
      StatsBean("Total Count", "0"),
      StatsBean("Total Price", "0"),
    ];
    typeList.clear();
    update();
  }

  listUpdate() async {
    getList();
  }
}
