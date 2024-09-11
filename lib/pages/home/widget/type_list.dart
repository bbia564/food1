import 'package:flutter/material.dart';
import 'package:foodtimer/pages/home/home_logic.dart';
import 'package:get/get.dart';
import '../../../widgets/empty_widget.dart';
import 'food_item.dart';

class TypeList extends StatelessWidget {
  const TypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LLHomeLogic>(
        autoRemove: false,
        builder: (controller) {
          if (controller.list.isEmpty) {
            return const EmptyWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.list.length,
            itemBuilder: (context, index) {
              final recode = controller.list[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/detail', arguments: {"food": recode});
                    },
                    child: FoodItem(
                      bean: recode,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: 53,
                  )
                ],
              );
            },
          );
        });
  }
}
