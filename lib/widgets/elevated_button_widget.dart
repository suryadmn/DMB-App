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
      height: buttonHeight ?? 48, // Default height of the button
      width: buttonWidth ?? double.infinity, // Default width of the button
      decoration: BoxDecoration(
        color: disabledButton ?? false
            ? ColorPalleteHelper.primary100 // Color when the button is disabled
            : buttonColor ??
                Theme.of(context)
                    .primaryColor, // Background color of the button
        borderRadius:
            BorderRadius.circular(8), // Rounded corners for the button
      ),
      child: ElevatedButton(
        // Define button press behavior based on loading and disabled state
        onPressed: isShowLoading
            ? () {} // Do nothing when loading
            : disabledButton ?? false
                ? () {} // Do nothing if the button is disabled
                : onPressed, // Call the provided onPressed function
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make background transparent
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Rounded corners for the button
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
          mainAxisAlignment:
              MainAxisAlignment.center, // Center align children in the row
          children: [
            // Loading indicator visibility
            Visibility(
              visible:
                  isShowLoading, // Show loading indicator based on isShowLoading
              child: Container(
                width: 24, // Width of the loading indicator
                height: 24, // Height of the loading indicator
                margin: const EdgeInsets.only(
                    right: 10.0), // Spacing between loading indicator and text
                child: const CircularProgressIndicator(
                  color: ColorPalleteHelper
                      .white, // Color of the loading indicator
                  strokeWidth: 3.0, // Thickness of the loading indicator
                ),
              ),
            ),
            // Button title visibility
            Visibility(
              visible: !isShowLoading, // Show button title when not loading
              child: Expanded(
                child: Text(
                  "$buttonTitle ", // Button title text
                  maxLines: 1, // Limit to one line
                  overflow: TextOverflow.ellipsis, // Handle text overflow
                  textAlign: TextAlign.center, // Center align button title
                  style: TextStyle(
                    color: buttonTextColor ??
                        ColorPalleteHelper.white, // Text color
                    fontSize: 16, // Font size of the button title
                    fontWeight:
                        FontWeight.w600, // Font weight of the button title
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
