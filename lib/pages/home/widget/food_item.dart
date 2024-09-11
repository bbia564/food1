import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtimer/entity/food_bean.dart';
import 'package:foodtimer/res/colors.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.bean,});

  final FoodBean bean;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF0F0F0F)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFF0F0F0))),
              width: 47,
              height: 47,
              child: bean.image == null
                  ? Image.asset("assets/images/ic_def_image.png")
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.memory(
                        bean.image!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
            5.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.themeColor.withOpacity(0.14)),
                        child: Text(
                          bean.type,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        bean.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: const Color(0xFF505050)),
                      )
                    ],
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: 'Quantity：',
                              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF898989)),
                              children: [
                                TextSpan(
                                    text: "x${bean.amount}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF505050),
                                        fontWeight: FontWeight.w500))
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text(
                              bean.overdue > 0 ? 'Days Until Expiration：' : 'Days Since Expired：',
                              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF898989)),
                            ),
                            Expanded(
                              child: Text(
                                "${bean.overdue.abs()}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFFFF8900),
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
