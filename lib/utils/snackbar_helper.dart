import 'package:flutter/material.dart';

class SnackbarHelper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    text, {
    Duration? snackbarDuration,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
            ],
            Expanded(child: Text(text, style: TextStyle(color: textColor))),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: snackbarDuration ?? const Duration(seconds: 4),
      ),
    );
  }
}
