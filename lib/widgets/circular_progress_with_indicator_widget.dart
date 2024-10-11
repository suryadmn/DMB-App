import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';

class CircularProgressWithIndicatorWidget extends StatelessWidget {
  final double progress;

  const CircularProgressWithIndicatorWidget({
    super.key,
    required this.progress,
  });

  // A method to calculate the color based on progress value
  Color _getProgressColor(double value) {
    if (value <= 3.3) {
      return ColorPalleteHelper.error; // Red for low progress
    } else if (value <= 6.6) {
      return ColorPalleteHelper.warning; // Yellow for medium progress
    } else {
      return ColorPalleteHelper.success; // Green for high progress
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 34,
          width: 34,
          child: CircularProgressIndicator(
            value: progress /
                10.0, // Normalize the value to 0.0 - 1.0 by dividing by 10
            strokeWidth: 4.0,
            backgroundColor:
                Colors.grey[300], // Background color of the progress indicator
            valueColor:
                AlwaysStoppedAnimation<Color>(_getProgressColor(progress)),
          ),
        ),
        // Display the percentage value at the center
        Text(
            '${(progress * 10).toInt()}%', // Convert progress to percentage (e.g., 6.5 -> 65%)
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
