import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker2/flutter_cupertino_datetime_picker2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodtimer/entity/food_bean.dart';
import 'package:foodtimer/pages/add/select_type_dialog.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../db/db_service.dart';
import '../../../utils/img_picker_util.dart';
import '../../calendar/logic.dart';
import '../../home/home_logic.dart';
import '../../stats/logic.dart';

class EditLogic extends GetxController {
  static EditLogic get to => Get.find<EditLogic>();
  final db = Get.find<DatabaseService>();
  Uint8List? foodImage;
  TextEditingController nameTEC = TextEditingController();
  TextEditingController typeTEC = TextEditingController();
  TextEditingController brandTEC = TextEditingController();
  TextEditingController amountTEC = TextEditingController(text: "0");
  TextEditingController priceTEC = TextEditingController();
  TextEditingController startTEC = TextEditingController();
  TextEditingController endTEC = TextEditingController();
  DateTime? startDateTime;
  DateTime? endDateTime;
  late FoodBean detailsBean;

  selectImage() {
    showImagePickerBottomSheet(Get.context!, callback: (XFile? file) async {
      if (file != null) {
        foodImage = await file.readAsBytes();
        update(['change_image']);
      }
    });
  }

  @override
  onInit() {
    detailsBean = Get.arguments["food"];
    foodImage = detailsBean.image;
    nameTEC.text = detailsBean.name;
    typeTEC.text = detailsBean.type;
    brandTEC.text = detailsBean.brand;
    amountTEC.text = "${detailsBean.amount}";
    priceTEC.text = "${detailsBean.price}";
    startTEC.text = detailsBean.startAt;
    endTEC.text = detailsBean.endAt;
    super.onInit();
  }

  selectStartDate() {
    DatePicker.showDatePicker(Get.context!,
        pickerMode: DateTimePickerMode.date,
        pickerTheme: const DateTimePickerTheme(
            cancelTextStyle: TextStyle(color: Color(0xFF939393), fontSize: 16),
            confirmTextStyle: TextStyle(color: AppColors.themeColor, fontSize: 16)),
        dateFormat: 'yyyy/MM/dd', onConfirm: (date, dateList) {
      startTEC.text = formatterDayMDY.format(date);
      startDateTime = date;
    });
  }

  final DateFormat formatterDayMDY = DateFormat('yyyy-MM-dd');

  selectEndDate() {
    DatePicker.showDatePicker(Get.context!,
        pickerMode: DateTimePickerMode.date,
        pickerTheme: const DateTimePickerTheme(
            cancelTextStyle: TextStyle(color: Color(0xFF939393), fontSize: 16),
            confirmTextStyle: TextStyle(color: AppColors.themeColor, fontSize: 16)),
        dateFormat: 'yyyy/MM/dd', onConfirm: (date, dateList) {
      endTEC.text = formatterDayMDY.format(date);
      endDateTime = date;
    });
  }

  selectType() {
    Get.to(SelectDialog(
      doneCallback: (select) {
        typeTEC.text = select.name;
      },
    ));
  }

  amountAdd() {
    if (amountTEC.text.isNotEmpty) {
      int aa = int.parse(amountTEC.text);
      aa++;
      amountTEC.text = "$aa";
    }
  }

  amountSub() {
    if (amountTEC.text.isNotEmpty) {
      int aa = int.parse(amountTEC.text);
      if (aa > 0) {
        aa--;
        amountTEC.text = "$aa";
      }
    }
  }

  addData() async {
    if (nameTEC.text.isEmpty ||
        typeTEC.text.isEmpty ||
        brandTEC.text.isEmpty ||
        amountTEC.text.isEmpty ||
        priceTEC.text.isEmpty ||
        startTEC.text.isEmpty ||
        endTEC.text.isEmpty) {
      EasyLoading.showToast("Please fill in the complete information.");
      return;
    }

    EasyLoading.show();

    var mmm = {
      "image": foodImage,
      "name": nameTEC.text,
      "type": typeTEC.text,
      "brand": brandTEC.text,
      "amount": int.parse(amountTEC.text),
      "price": double.parse(priceTEC.text)
    };
    if (startDateTime != null) {
      mmm["start_at"] = startDateTime!.toIso8601String().split('T')[0];
    }
    if (endDateTime != null) {
      mmm["end_at"] = endDateTime!.toIso8601String().split('T')[0];
    }
    int vv = await db.update(
      detailsBean.id,
      mmm,
    );
    if (vv < 0) {
      EasyLoading.showToast("Update Failed");
      return;
    }
    LLHomeLogic.to.listUpdate();

    CalendarLogic.to.listUpdate();

    StatsLogic.to.listUpdate();

    Future.delayed(const Duration(seconds: 1)).then((v) {
      EasyLoading.dismiss();
      Get.back(result: true);
    });
  }
}
