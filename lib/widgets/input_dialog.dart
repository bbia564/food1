import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/widgets/outline_input.dart';
import 'package:get/get.dart';

class InputDialog extends StatelessWidget {
  const InputDialog({super.key, required this.title, this.subtitle, required this.controller});

  final String title;
  final String? subtitle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 120.h, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 14.sp, color: const Color(0xFF242424), fontWeight: FontWeight.w700),
              ),
            ),
            subtitle == null
                ? const SizedBox()
                : Text(
                    subtitle!,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF242424),
                        fontWeight: FontWeight.w700),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: OutlineInput(
                  controller: controller,
                  keyboardType: subtitle != null ? TextInputType.number : null,
                  inputFormatters: subtitle != null
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                        ]
                      : []),
            ),
            const Divider(
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF242424),
                        fontSize: 14.sp,
                      )),
                )),
                const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      width: 1,
                    )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      EasyLoading.showToast("Please Enter");
                      return;
                    }
                    Get.back(result: controller.text);
                  },
                  child: Text("Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF242424),
                        fontSize: 14.sp,
                      )),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
