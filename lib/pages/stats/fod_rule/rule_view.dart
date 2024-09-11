import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rule_logic.dart';

class RuleView extends GetView<PageLogic> {
  const RuleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.stokes.value
              ? const CircularProgressIndicator(color: Colors.amber)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.afxen();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
