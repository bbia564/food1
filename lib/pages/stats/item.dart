import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/res/colors.dart';

import '../../entity/stats_bean.dart';

class StatsItem extends StatelessWidget {
  const StatsItem({super.key, required this.bean});

  final StatsBean bean;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              bean.name,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF505050)),
            ),
          ),
          Text(
            bean.count,
            style: TextStyle(
                fontSize: 16.sp, color: AppColors.themeColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
