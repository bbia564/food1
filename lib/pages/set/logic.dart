import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/db/cons.dart';
import 'package:foodtimer/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/db_service.dart';
import '../../widgets/input_dialog.dart';
import '../calendar/logic.dart';
import '../home/home_logic.dart';
import '../stats/logic.dart';

class SettingLogic extends GetxController {
  final db = Get.find<DatabaseService>();
  var version = "".obs;
  var expiringDay = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAppInfo();
  }

  Future<void> getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    version.value = info.version;
    int day = await SharedPreferencesUtil.getInt("expiringDay", defaultValue: Cons.expiringDay);
    expiringDay.value = "$day";
  }

  onAbout() async {
    var info = await PackageInfo.fromPlatform();
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("About"),
          ),
          body: Column(
            children: [
              20.verticalSpace,
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    "assets/images/ic_launcher.png",
                    width: 70,
                  )),
              10.verticalSpace,
              Text(info.appName),
              5.verticalSpace,
              Text("v ${info.version}"),
              const Expanded(
                child: Markdown(
                  data: """
BabyMemo, a thoughtful assistant for every parent and caregiver. We understand that a baby's growth requires careful attention and detailed record-keeping. Therefore, we have specially developed this easy-to-use and feature-packed app to help parents and caregivers effortlessly track and record their baby's diaper changes, feeding times, and sleeping schedules, making the parenting process more organized and efficient.
          """,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onSetExpiry() {
    Get.dialog(InputDialog(
      title: 'Set Expiry Reminder',
      subtitle: "Enter Days",
      controller: TextEditingController(),
    )).then((v) async {
      if (v != null) {
        Cons.expiringDay = int.parse(v);
        await SharedPreferencesUtil.setInt("expiringDay", Cons.expiringDay);
        expiringDay.value = "${Cons.expiringDay}";
        EasyLoading.showToast("Set Successful");
      }
    });
  }

  onAddCategory() {
    Get.dialog(InputDialog(
      title: 'Add Category',
      controller: TextEditingController(),
    )).then((v) async {
      if (v != null) {
        try {
          await db.addType(v);
          EasyLoading.showToast("Add Successful");
        } on DatabaseException catch (e) {
          EasyLoading.showToast("Add Failed");
        }
      }
    });
  }

  onPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(
            data: """
#### Data Collection
Our app does not collect any personal information or user data. All triangle calculations are performed locally on the device and are not transmitted to any external servers.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """,
          ),
        );
      },
    );
  }

  onCleanData() async {
    Get.dialog(AlertDialog(
      title: const Text('Delete'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)), // 设置圆角
      ),
      content: const Text('Are you sure you want to delete all data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await db.clean();
            Get.back();
            try {
              LLHomeLogic.to.clear();
              CalendarLogic.to.clear();
              StatsLogic.to.clear();
            } catch (e) {}
          },
          child: const Text('Confirm'),
        ),
      ],
    ));
  }
}
