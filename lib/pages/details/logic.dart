import 'package:get/get.dart';

import '../../entity/food_bean.dart';

class DetailsController extends GetxController {
  late FoodBean bean;

  @override
  void onInit() {
    bean = Get.arguments["food"];
    super.onInit();
  }

  onEdit() {
    Get.toNamed('/edit', arguments: {"food": bean})?.then((v) {
      if (v == true) {
        Get.back();
      }
    });
  }
}
