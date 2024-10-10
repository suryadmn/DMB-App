import 'package:flutter/material.dart';

import '../utils/color_pallete_helper.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final String buttonTitle;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool isShowLoading;
  final VoidCallback? onPressed;
  final bool? disabledButton;
  const ElevatedButtonWidget(
      {super.key,
      required this.buttonTitle,
      required this.isShowLoading,
      this.buttonHeight,
      this.buttonWidth,
      this.buttonColor,
      this.buttonTextColor,
      this.onPressed,
      this.disabledButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 48,
      width: buttonWidth ?? double.infinity,
      decoration: BoxDecoration(
        color: disabledButton ?? false
            ? ColorPalleteHelper.primary100
            : buttonColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: ElevatedButton(
        onPressed: isShowLoading
            ? () {}
            : disabledButton ?? false
                ? () {}
                : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: disabledButton ?? false
                  ? ColorPalleteHelper.white
                  : buttonTextColor != null
                      ? ColorPalleteHelper.gray
                      : Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isShowLoading,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 10.0),
                child: const CircularProgressIndicator(
                  color: ColorPalleteHelper.white,
                  strokeWidth: 3.0,
                ),
              ),
            ),
            Visibility(
              visible: !isShowLoading,
              child: Expanded(
                child: Text(
                  "$buttonTitle ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: buttonTextColor ?? ColorPalleteHelper.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
