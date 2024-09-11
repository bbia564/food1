import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/db/cons.dart';
import 'package:foodtimer/pages/home/widget/food_item.dart';
import 'package:get/get.dart';

import '../../entity/expired_bean.dart';
import '../../res/colors.dart';
import '../../widgets/empty_widget.dart';
import 'calender_head.dart';
import 'logic.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends GetView<CalendarLogic> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarLogic>(builder: (_) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                ValueListenableBuilder<DateTime>(
                  valueListenable: controller.focusedDay,
                  builder: (context, value, _) {
                    return CalendarHeader(
                      focusedDay: value,
                      onLeftArrowTap: () {
                        controller.pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      onRightArrowTap: () {
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TableCalendar<ExpiredBean>(
                    firstDay: DateTime.utc(2024, 5, 1),
                    lastDay: DateTime.now().add(Duration(days: Cons.expiringDay)),
                    focusedDay: controller.focusedDay.value,
                    rowHeight: 40,
                    onCalendarCreated: (pagC) => controller.pageController = pagC,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: RangeSelectionMode.toggledOff,
                    eventLoader: (da) {
                      return controller.list;
                    },
                    onDaySelected: controller.onDaySelected,
                    onPageChanged: controller.onPageChanged,
                    selectedDayPredicate: (day) => isSameDay(controller.focusedDay.value, day),
                    calendarBuilders: CalendarBuilders(markerBuilder: (c, d, t) {
                      for (var e in t) {
                        if (isSameDay(d, controller.formatterDay.parse(e.day))) {
                          return Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.themeColor,
                            ),
                          );
                        }
                      }
                      return const SizedBox();
                    }),
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: AppColors.themeColor.withOpacity(0.2),
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(4))),
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          shape: BoxShape.rectangle,
                        ),
                        todayTextStyle: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                    headerVisible: false,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: REdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: REdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expiration date: ${controller.formatterMDY.format(controller.focusedDay.value)}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeColor),
                      ),
                    ],
                  ),
                  14.verticalSpace,
                  const Divider(
                    height: 1,
                  ),
                  Expanded(child: _buildListView()),
                ],
              ),
            ),
          ),
          40.verticalSpace,
        ],
      );
    });
  }

  Widget _buildListView() {
    if (controller.todayList.isEmpty) {
      return const EmptyWidget();
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.todayList.length,
      itemBuilder: (context, index) {
        final recode = controller.todayList[index];
        return InkWell(
          onTap: () {
            Get.toNamed('/detail', arguments: {"food": recode});
          },
          child: Column(
            children: [
              FoodItem(
                bean: recode,
              ),
              const Divider(
                height: 1,
                indent: 53,
              )
            ],
          ),
        );
      },
    );
  }
}
