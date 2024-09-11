import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PieChartItem extends StatelessWidget {
  const PieChartItem(
      {super.key,
      required this.color,
      required this.tag,
      required this.time,
      this.showDivider = true});

  final Color color;
  final String tag;
  final String time;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        5.horizontalSpace,
        Text(
          tag,
          style: TextStyle(color:color ,fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
           Expanded(
              child: showDivider?const Divider(
            height: 1,
            indent: 3,
            endIndent: 8,
          ):const SizedBox()),
        Text(
          time,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
      ],
    );
  }
}
