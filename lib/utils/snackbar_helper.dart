import 'package:flutter/material.dart';

/// A helper class to display SnackBar messages with customization options.
class SnackbarHelper {
  /// Displays a [SnackBar] with a customizable message, duration, background color,
  /// text color, and an optional icon.
  ///
  /// - [context] is required to access the ScaffoldMessenger.
  /// - [text] is the message to be displayed in the SnackBar.
  /// - [snackbarDuration] allows you to set the duration the SnackBar will be visible.
  ///   If not provided, it defaults to 4 seconds.
  /// - [backgroundColor] sets the background color of the SnackBar.
  /// - [textColor] sets the color of the text inside the SnackBar.
  /// - [icon] (optional) adds an icon to the left of the text in the SnackBar.
  /// - [iconColor] sets the color of the optional icon.
  /// - [isNeedOpenFile] (optional) indicates if the 'Open' button should be displayed.
  /// - [openFile] (optional) is a callback function that is executed when the 'Open' button is pressed.
  ///
  /// Example usage:
  /// ```dart
  /// SnackbarHelper.show(
  ///   context,
  ///   'This is a message',
  ///   backgroundColor: Colors.green,
  ///   textColor: Colors.white,
  ///   icon: Icons.check,
  ///   iconColor: Colors.white,
  /// );
  /// ```
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    String text, {
    Duration? snackbarDuration,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
    bool? isNeedOpenFile,
    Function()? openFile,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the icon if provided
            if (icon != null) ...[
              Icon(icon, color: iconColor), // Icon on the left
              const SizedBox(width: 10), // Spacing between icon and text
            ],
            Expanded(
              child: Text(text,
                  style: TextStyle(color: textColor)), // SnackBar message
            ),
            // Conditional rendering of the 'Open' button if needed
            isNeedOpenFile ?? false
                ? TextButton(
                    onPressed: openFile, // Action for the button
                    child: Text(
                      'Open',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700), // Button text style
                    ))
                : const SizedBox(), // Empty widget if no button is needed
          ],
        ),
        backgroundColor: backgroundColor, // Background color for SnackBar
        duration: snackbarDuration ??
            const Duration(seconds: 4), // Duration of display
      ),
    );
  }
}
