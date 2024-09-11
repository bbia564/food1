import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';
import '../../res/style.dart';
import 'logic.dart';

class SetPage extends GetView<SettingLogic> {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: REdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Set Expiry Reminder',
                          style: AppStyle.tipStyles,
                        ),
                      ),
                      Obx(() => Text(
                            "${controller.expiringDay.value} days",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF0F0F0F)),
                          ))
                    ],
                  ),
                  onTap: () {
                    controller.onSetExpiry();
                  },
                  trailing: Image.asset(
                    "assets/images/ic_arrow.png",
                    width: 20,
                  )),
              const Divider(
                height: 0,
              ).paddingOnly(left: 17, right: 17),
              ListTile(
                  title: Text(
                    'Add Category',
                    style: AppStyle.tipStyles,
                  ),
                  onTap: () {
                    controller.onAddCategory();
                  },
                  trailing: Image.asset(
                    "assets/images/ic_arrow.png",
                    width: 20,
                  )),
              const Divider(
                height: 0,
              ).paddingOnly(left: 17, right: 17),
              ListTile(
                  title: Text(
                    'Clean Data',
                    style: AppStyle.tipStyles,
                  ),
                  onTap: () {
                    controller.onCleanData();
                  },
                  trailing: Image.asset(
                    "assets/images/ic_arrow.png",
                    width: 20,
                  )),
            ],
          ),
        ),
        Container(
          margin: REdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Divider(
                height: 0,
              ).paddingOnly(left: 17, right: 17),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Version',
                        style: AppStyle.tipStyles,
                      ),
                    ),
                    Obx(() => Text(
                          "V${controller.version.value}",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 14.sp,
                          ),
                        ))
                  ],
                ),
                trailing: Image.asset(
                  "assets/images/ic_arrow.png",
                  width: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
