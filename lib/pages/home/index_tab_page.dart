import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../calendar/calendar_page.dart';
import '../set/set_page.dart';
import '../stats/stats_page.dart';
import 'home_page.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreenPage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  String title = "List";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/addFood');
              },
              padding: EdgeInsets.zero,
              icon: Image.asset(
                "assets/images/ic_aadd.png",
                width: 30,
              ))
        ],
      ),
      body: LazyLoadIndexedStack(
        index: currentIndex,
        children: const [HomePage(), HistoryPage(), StatsPage(), SetPage()],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: AppColors.themeColor,
      unselectedItemColor: AppColors.themeText.withOpacity(0.4),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_home.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_home_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_calendar.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_calendar_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_statistics.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_statistics_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_set.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          activeIcon: Image.asset("assets/images/ic_set_s.png",
              width: 22.w,
              excludeFromSemantics: true, //去除图片语义
              gaplessPlayback: true),
          label: 'Setting',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          if (currentIndex == 0) {
            title = "List";
          }
          if (currentIndex == 1) {
            title = "Calendar";
          }
          if (currentIndex == 2) {
            title = "Stats";
          }
          if (currentIndex == 3) {
            title = "Setting";
          }
        });
      },
    );
  }
}
