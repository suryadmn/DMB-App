import 'package:flutter/material.dart';
import '../utils/color_pallete_helper.dart';

/// A customizable elevated button widget.
///
/// This widget allows you to create an elevated button with loading state,
/// customizable dimensions, colors, and click actions.
class ElevatedButtonWidget extends StatelessWidget {
  /// Height of the button. Defaults to 48 if not provided.
  final double? buttonHeight;

  /// Width of the button. Defaults to full width if not provided.
  final double? buttonWidth;

  /// Title text displayed on the button.
  final String buttonTitle;

  /// Background color of the button. Defaults to theme primary color if not provided.
  final Color? buttonColor;

  /// Color of the button text. Defaults to white if not provided.
  final Color? buttonTextColor;

  /// Indicates if the loading spinner should be shown.
  final bool isShowLoading;

  /// Callback function executed when the button is pressed.
  final VoidCallback? onPressed;

  /// Indicates if the button is disabled.
  final bool? disabledButton;

  const ElevatedButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.isShowLoading,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonColor,
    this.buttonTextColor,
    this.onPressed,
    this.disabledButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 48, // Default height
      width: buttonWidth ?? double.infinity, // Default width
      decoration: BoxDecoration(
        color: disabledButton ?? false
            ? ColorPalleteHelper.primary100 // Disabled color
            : buttonColor ?? Theme.of(context).primaryColor, // Button color
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: ElevatedButton(
        // Define button press behavior based on loading and disabled state
        onPressed: isShowLoading
            ? () {} // No action during loading
            : disabledButton ?? false
                ? () {} // No action if disabled
                : onPressed, // Call provided onPressed function
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent background
          shadowColor: Colors.transparent, // No shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
            side: BorderSide(
              color: disabledButton ?? false
                  ? ColorPalleteHelper.white // Border color when disabled
                  : buttonTextColor != null
                      ? ColorPalleteHelper
                          .gray // Border color based on text color
                      : Theme.of(context).primaryColor, // Default border color
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center align child
          children: [
            // Loading indicator visibility
            Visibility(
              visible: isShowLoading,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 10.0), // Spacing
                child: const CircularProgressIndicator(
                  color: ColorPalleteHelper.white, // Loading indicator color
                  strokeWidth: 3.0, // Thickness of loading indicator
                ),
              ),
            ),
            // Button title visibility
            Visibility(
              visible: !isShowLoading,
              child: Expanded(
                child: Text(
                  "$buttonTitle ",
                  maxLines: 1, // Limit text to one line
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  textAlign: TextAlign.center, // Center align text
                  style: TextStyle(
                    color: buttonTextColor ??
                        ColorPalleteHelper.white, // Text color
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.w600, // Font weight
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
