import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/entity/type_bean.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:get/get.dart';

import '../../db/db_service.dart';
import '../../res/style.dart';

typedef DoneCallback = void Function(TYpeBean slect);

class SelectDialog extends StatefulWidget {
  const SelectDialog({
    super.key,
    required this.doneCallback,
    this.defValue,
  });

  final DoneCallback doneCallback;
  final String? defValue;

  @override
  State<SelectDialog> createState() => _SINGMoreInfoItemDialogState();
}

class _SINGMoreInfoItemDialogState extends State<SelectDialog> {
  List<TYpeBean> labelData = [];

  final db = Get.find<DatabaseService>();

  // 定义 ScrollController，并设置初始值
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  final ValueNotifier<TYpeBean> selectLabel = ValueNotifier<TYpeBean>(TYpeBean(0, ""));

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    labelData = await db.getAllTypes();

    int defIndex = 0;
    if (widget.defValue != null) {
      for (int i = 0; i < labelData.length; i++) {
        if (widget.defValue == labelData[i].name) {
          defIndex = i;
          break;
        }
      }
    }

    setState(() {
      selectLabel.value = labelData[defIndex];
      scrollController.animateToItem(defIndex,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Category"),
          actions: [
            TextButton(
                onPressed: () {
                  widget.doneCallback.call(selectLabel.value);
                  Get.back();
                },
                child: const Text(
                  "Done",
                  style: TextStyle(color: AppColors.themeColor),
                ))
          ],
        ),
        body: Container(
          decoration: AppStyle.defDecoration,
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: context.height / 3,
                child: CupertinoPicker(
                  itemExtent: 48.h,
                  scrollController: scrollController,
                  onSelectedItemChanged: (int index) {
                    selectLabel.value = labelData[index];
                  },
                  children: List.generate(labelData.length, (index) {
                    return Center(
                      child: Text(
                        labelData[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }),
                ),
              ),
              20.verticalSpace
            ],
          ),
        ));
  }
}
