import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:foodtimer/widgets/app_item_tile.dart';
import 'package:get/get.dart';
import '../../res/style.dart';
import 'add_food_logic.dart';

class AddFoodPage extends GetView<AddFoodLogicLogic> {
  const AddFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
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
                      child: GetBuilder<AddFoodLogicLogic>(
                          id: "change_image",
                          builder: (_) {
                            return InkWell(
                              onTap: () {
                                controller.selectImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  controller.foodImage == null
                                      ? Image.asset(
                                          "assets/images/ic_add_photo.png",
                                          width: 43,
                                          height: 43,
                                        )
                                      : Image.memory(
                                          controller.foodImage!,
                                          fit: BoxFit.fitWidth,
                                          width: 90,
                                        ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    AppItemTile(
                      leadingText: "Name",
                      style: ItemStyle.input,
                      editController: controller.nameTEC,
                    ),
                    AppItemTile(
                      style: ItemStyle.select,
                      leadingText: "Category",
                      editController: controller.typeTEC,
                      onTap: () {
                        controller.selectType();
                      },
                    ),
                    AppItemTile(
                      style: ItemStyle.input,
                      leadingText: "Brand",
                      editController: controller.brandTEC,
                    ),
                    AppItemTile(
                      style: ItemStyle.text,
                      leadingText: "Quantity",
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.amountSub();
                            },
                            child: Image.asset(
                              "assets/images/ic_jian.png",
                              width: 20,
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(minWidth: 32.0, maxWidth: 60),
                            child: TextField(
                              controller: controller.amountTEC,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.amountAdd();
                            },
                            child: Image.asset(
                              "assets/images/ic_jia.png",
                              width: 20,
                            ),
                          )
                        ],
                      ),
                      // editController: controller.amountTEC,
                      // keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      // ],
                    ),
                    AppItemTile(
                      style: ItemStyle.input,
                      hideDivider: true,
                      leadingText: "Unit Price",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      editController: controller.priceTEC,
                    ),
                  ]),
            ),
            Container(
              decoration: AppStyle.defDecoration,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppItemTile(
                      style: ItemStyle.select,
                      leadingText: "Manufacturing Date",
                      editController: controller.startTEC,
                      onTap: () {
                        controller.selectStartDate();
                      },
                    ),
                    AppItemTile(
                      style: ItemStyle.select,
                      leadingText: "Expiry Date",
                      hideDivider: true,
                      editController: controller.endTEC,
                      onTap: () {
                        controller.selectEndDate();
                      },
                    ),
                  ]),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: SizedBox(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addData();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.themeColor,
                          // 设置边框颜色和宽度
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          // 设置边框颜色和宽度
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
