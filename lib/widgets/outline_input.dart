import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineInput extends StatelessWidget {
  const OutlineInput(
      {super.key,
      required this.controller,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType});

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFD0D0D0))),
      child: TextField(
        style: TextStyle(fontSize: 14.sp, color: const Color(0xFFB9B9B9)),
        textAlign: TextAlign.center,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ??
            [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xFFD3D3D3))),
      ),
    );
  }
}
