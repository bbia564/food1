import 'package:flutter/material.dart';

class Cons {
  // 为每个状态提供一个颜色
//  娱乐 - Entertainment
//  吃饭 - Meal
//  休息 - Rest
//  学习 - Study
  static Map<String, Color> statusColors = {
    "Fun": const Color(0xFF575FCF),
    "Meal": const Color(0xFFFFA801),
    "Rest": const Color(0xFFF53B57),
    "Study": const Color(0xFF57C664),
  };

  static List<String> tags = ["All", "Active", "Expired", "Near Expired","Total Count","Total Price"];
  static int expiringDay = 3;
}
