import 'package:another_flushbar/flushbar.dart';
import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  /// Shows a Flushbar notification at the top of the screen.
  ///
  /// [context] is the BuildContext used to display the Flushbar.
  /// [text] is the message to be displayed.
  /// [status] indicates the type of notification (default is 'w' for warning).
  static Flushbar show(context, text, {status = 'w'}) {
    return Flushbar(
      message: text, // The message to display
      flushbarPosition: FlushbarPosition.TOP, // Position of the Flushbar
      icon: Icon(
        Icons.info_outline, // Icon to display in the Flushbar
        size: 28.0,
        color: status == 'w' // w = warning
            ? ColorPalleteHelper.warning // Color for warning status
            : status == 'i' // i = info
                ? ColorPalleteHelper.primary500 // Color for info status
                : ColorPalleteHelper.error, // e = error, color for error status
      ),
      duration: const Duration(
          seconds: 5), // Duration for which the Flushbar is displayed
      leftBarIndicatorColor: status == 'w' // w = warning
          ? ColorPalleteHelper.warning // Left bar color for warning status
          : status == 'i' // i = info
              ? ColorPalleteHelper.primary500 // Left bar color for info status
              : ColorPalleteHelper
                  .error, // e = error, left bar color for error status
    )..show(context); // Display the Flushbar
  }
}
