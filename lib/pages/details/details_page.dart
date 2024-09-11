import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/widgets/app_item_tile.dart';
import 'package:get/get.dart';
import '../../res/style.dart';
import 'logic.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
              onPressed: () {
                controller.onEdit();
              },
              icon: Image.asset(
                "assets/images/ic_edit.png",
                width: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: AppStyle.defDecoration,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      margin: REdgeInsets.only(top: 22, bottom: 17),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8)),
                      child: controller.bean.image == null
                          ? Image.asset("assets/images/ic_def_image.png")
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                controller.bean.image!,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        controller.bean.name,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF2B2B2B)),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    AppItemTile(
                      leadingText: "Quantity：",
                      trailingText: "${controller.bean.amount}",
                    ),
                    AppItemTile(
                      leadingText: "Manufacturing Date",
                      trailingText: controller.bean.startAt,
                    ),
                    AppItemTile(
                      leadingText: "Expiry Date",
                      trailingText: controller.bean.endAt,
                    ),
                    AppItemTile(
                      leadingText: "Unit Price：",
                      trailingText: "${controller.bean.price}",
                    ),
                    AppItemTile(
                      leadingText: "Brand：",
                      trailingText: controller.bean.brand,
                      hideDivider: true,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
