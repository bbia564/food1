import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.verticalSpace,
          Image.asset(
            "assets/images/ic_empty.png",
            height: 55,
          ),
          Text(
            "No data available",
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFFADADAD), height: 1.6),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
