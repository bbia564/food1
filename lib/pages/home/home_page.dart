import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/pages/home/widget/type_list.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:get/get.dart';
import 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(() {
      if (tabController.animation!.isCompleted) {
        EasyLoading.showToast("${tabController.index}");
        LLHomeLogic.to.getList(tabController.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.themeText),
                    isScrollable: true,
                    splashBorderRadius: BorderRadius.circular(10),
                    tabAlignment: TabAlignment.center,
                    dividerColor: AppColors.dividerColor,
                    indicatorColor: AppColors.themeColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14.sp, color: const Color(0xFFA8A8A8)),
                    tabs: const [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Active",
                      ),
                      Tab(
                        text: "Expired",
                      ),
                      Tab(
                        text: "Near Expiry",
                      )
                    ]),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  children: const [
                    TypeList(),
                    TypeList(),
                    TypeList(),
                    TypeList(),
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
