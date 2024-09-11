
import 'package:flutter/cupertino.dart';
import 'package:foodtimer/entity/food_bean.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../db/db_service.dart';
import '../../entity/expired_bean.dart';

class CalendarLogic extends GetxController {
  static CalendarLogic get to => Get.find<CalendarLogic>();
  final db = Get.find<DatabaseService>();
  final DateFormat formatterDay = DateFormat('yyyy-MM-dd');
  final DateFormat formatterMDY = DateFormat('MM/dd/yyyy');
  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  late PageController pageController;
  List<ExpiredBean> list = <ExpiredBean>[];
  List<FoodBean> todayList = <FoodBean>[];

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    list = await db.getAllDay();
    todayList = list
            .firstWhereOrNull((v) => isSameDay(focusedDay.value, formatterDay.parse(v.day)))
            ?.list ??
        [];
    update();
  }


  Future<void> onDaySelected(DateTime selectedDay, DateTime chioseDay) async {
    if (!isSameDay(focusedDay.value, chioseDay)) {
      focusedDay.value = chioseDay;
      todayList = list
              .firstWhereOrNull((v) => isSameDay(focusedDay.value, formatterDay.parse(v.day)))
              ?.list ??
          [];
      update();
    }
  }

  Future<void> onPageChanged(DateTime dd) async {
    focusedDay.value = dd;
    todayList = list
            .firstWhereOrNull((v) => isSameDay(focusedDay.value, formatterDay.parse(v.day)))
            ?.list ??
        [];
    update();
  }
  clear(){
    list.clear();
    todayList.clear();
    update();
  }
  listUpdate() async {
    await getList();
    update();
  }
}
