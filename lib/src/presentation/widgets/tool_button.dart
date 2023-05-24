import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

class ToolButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final Color? backGroundColor;
  final EdgeInsets? padding;
  final Function()? onLongPress;
  final Color colorBorder;
  const ToolButton(
      {Key? key,
      required this.onTap,
      required this.child,
      this.backGroundColor,
      this.padding,
      this.onLongPress,
      this.colorBorder = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: AnimatedOnTapButton(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 10).r,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(90),
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.5),
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                  color: backGroundColor ?? Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorBorder, width: 2.w)),
              child: Transform.scale(
                scale: 0.8.r,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
