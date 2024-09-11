import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/pages/add/add_food_logic.dart';
import 'package:foodtimer/pages/add/add_food_page.dart';
import 'package:foodtimer/pages/calendar/logic.dart';
import 'package:foodtimer/pages/details/details_page.dart';
import 'package:foodtimer/pages/details/edit/edit_page.dart';
import 'package:foodtimer/pages/details/edit/logic.dart';
import 'package:foodtimer/pages/details/logic.dart';
import 'package:foodtimer/pages/home/home_logic.dart';
import 'package:foodtimer/pages/home/index_tab_page.dart';
import 'package:foodtimer/pages/home/widget/food_list.dart';
import 'package:foodtimer/pages/set/logic.dart';
import 'package:foodtimer/pages/stats/fod_rule/rule_binding.dart';
import 'package:foodtimer/pages/stats/fod_rule/rule_view.dart';
import 'package:foodtimer/pages/stats/logic.dart';
import 'package:foodtimer/res/style.dart';
import 'package:get/get.dart';

import 'db/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 设置状态栏文字和图标颜色为亮色（白色）
  ));
  //禁止横屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    ); //支持分屏
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: FoodPs,
      builder: (context, child) {
        return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: Scaffold(
              // Global GestureDetector that will dismiss the keyboard
              resizeToAvoidBottomInset: false,
              body: KeyboardDismissOnTap(
                child: FlutterEasyLoading(
                  child: child,
                ),
              ),
            ));
      },
      theme: AppStyle.lightTheme,
      // themeMode: ThemeMode.light,
      //页面跳转风格
      defaultTransition: Transition.cupertino,
    );
  }
}

List<GetPage<dynamic>> FoodPs = [
  GetPage(
      name: '/',
      page: () => const RuleView(),
      binding: RuleBinding()
  ),
  GetPage(
      name: '/home',
      page: () => const HomeScreenPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<LLHomeLogic>(() => LLHomeLogic());
          Get.lazyPut<CalendarLogic>(() => CalendarLogic(),fenix: true);
          Get.lazyPut<StatsLogic>(() => StatsLogic(),fenix: true);
          Get.lazyPut<SettingLogic>(() => SettingLogic());
        },
      )),
  GetPage(
      name: '/addFood',
      page: () => const AddFoodPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<AddFoodLogicLogic>(() => AddFoodLogicLogic());
        },
      )),
  GetPage(
      name: '/rule_con',
      page: () => const RuleListCon()
  ),
  GetPage(
      name: '/detail',
      page: () => const DetailsPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<DetailsController>(() => DetailsController());
        },
      )),
  GetPage(
      name: '/edit',
      page: () => const EditPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<EditLogic>(() => EditLogic());
        },
      ))
];
