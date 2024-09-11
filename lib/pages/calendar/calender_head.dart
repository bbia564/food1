import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/res/colors.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,

  });

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);
    return Row(
      children: [
        const SizedBox(width: 16.0),
        SizedBox(
          width: 120.0,
          child: Text(
            headerText,
            style:  TextStyle(fontSize: 18.0.sp,color: AppColors.themeColor,fontWeight: FontWeight.w600),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.themeColor,
          ),
          onPressed: onLeftArrowTap,
        ),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
            color: AppColors.themeColor,
          ),
          onPressed: onRightArrowTap,
        ),
      ],
    );
  }
}
