import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///根据app样式封装的每条 输入信息的布局样式//////
///
enum ItemStyle { input, select, text }

class AppItemTile extends StatelessWidget {
  const AppItemTile(
      {super.key,
      this.style = ItemStyle.text,
      this.hintText,
      this.leadingText,
      this.hideDivider = false,
      this.trailingText,
      this.onTap,
      this.onTextChanged,
      this.trailingWidget,
      this.editController,
      this.validator,
      this.leadingTextStyle,
      this.trailingTextStyle,
      this.leadingWidget,
      this.textAlign = TextAlign.end,
      this.contentPadding = EdgeInsets.zero,
      this.titleWidget,
      this.maxLines,
      this.obscureText = false,
      this.inputFormatters,
      this.keyboardType,
      this.enabled});

  final ItemStyle? style;
  final String? hintText;
  final String? leadingText;
  final String? trailingText;
  final TextStyle? leadingTextStyle;
  final TextStyle? trailingTextStyle;
  final bool hideDivider;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onTextChanged;
  final Widget? trailingWidget;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final TextEditingController? editController;
  final FormFieldValidator<String>? validator;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final bool obscureText;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color: hideDivider ? Colors.transparent : Colors.black.withOpacity(0.08)),
              top: const BorderSide(color: Colors.transparent))),
      child: ListTile(
        horizontalTitleGap: 10,
        contentPadding: contentPadding,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
          FocusScope.of(context).requestFocus(FocusNode());
        },
        leading: leadingWidget ??
            Text(
              leadingText ?? '',
              style: leadingTextStyle ??
                  TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                      color: const Color(0xFF2B2B2B)),
            ),
        title: SizedBox(height: 20, child: titleWidget ?? _buildTitleWidget()),
        trailing: style == ItemStyle.select
            ? trailingWidget ??
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xFFAAAAAA),
                  size: 15.sp,
                )
            : trailingWidget,
      ),
    );
  }

  Widget _buildTitleWidget() {
    switch (style) {
      case ItemStyle.input:
        return TextFormField(
            textAlign: textAlign,
            style: trailingTextStyle ?? TextStyle(fontSize: 14.sp, color: const Color(0xFF0F0F0F)),
            onChanged: onTextChanged,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            keyboardType: keyboardType,
            controller: editController ?? TextEditingController(text: trailingText),
            validator: validator,
            enabled: enabled,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText ?? "input",
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(
                  fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFFB5B5B5)),
            ));
      case ItemStyle.select:
        return IgnorePointer(
          child: TextFormField(
              controller: editController ?? TextEditingController(text: trailingText),
              textAlign: textAlign,
              style:
                  trailingTextStyle ?? TextStyle(fontSize: 14.sp, color: const Color(0xFF0F0F0F)),
              // enabled: false,
              validator: validator,
              onChanged: onTextChanged,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFFB5B5B5)),
              )),
        );
      default:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            trailingText ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF0F0F0F)),
          ),
        );
    }
  }
}
