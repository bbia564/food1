import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'item.dart';
import 'logic.dart';

class StatsPage extends GetView<StatsLogic> {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: GetBuilder<StatsLogic>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 167 / 52,
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: controller.grList.length,
              itemBuilder: (BuildContext context, int index) {
                var bean = controller.grList[index];
                return StatsItem(
                  bean: bean,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32,bottom: 10),
              child: Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 167 / 52,
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: controller.typeList.length,
              itemBuilder: (BuildContext context, int index) {
                var bean = controller.typeList[index];
                return StatsItem(
                  bean: bean,
                );
              },
            )
          ],
        );
      }),
    );
  }
}
