import 'package:another_flushbar/flushbar.dart';
import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  static Flushbar show(context, text, {status = 'w'}) {
    return Flushbar(
      message: text,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: status == 'w' //w = warning
            ? ColorPalleteHelper.warning
            : status == 'i' //i = info
                ? ColorPalleteHelper.primary500
                : ColorPalleteHelper.error, //e = error
      ),
      duration: const Duration(seconds: 5),
      leftBarIndicatorColor: status == 'w' //w = warning
          ? ColorPalleteHelper.warning
          : status == 'i' //i = info
              ? ColorPalleteHelper.primary500
              : ColorPalleteHelper.error, //e = error
    )..show(context);
  }
}
