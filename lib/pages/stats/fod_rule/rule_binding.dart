import 'package:get/get.dart';

import 'rule_logic.dart';

class RuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
