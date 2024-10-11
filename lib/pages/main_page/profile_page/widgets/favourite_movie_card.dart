import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../datas/networking/url_access.dart';
import '../../../../utils/color_pallete_helper.dart';
import '../../../../widgets/circular_progress_with_indicator_widget.dart';

class FavouriteMovieCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  const FavouriteMovieCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.voteAverage,
      required this.releaseDate,
      required this.overview});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12), // Adjust the card's border radius
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              width: 160,
              imageUrl: "${UrlAccess.urlBaseMedia}$imagePath",
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 44,
                  color: ColorPalleteHelper.error,
                ),
              ),
              fit:
                  BoxFit.fitHeight, // Ensures the image covers the CircleAvatar
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircularProgressWithIndicatorWidget(
                      progress:
                          voteAverage, // Progress value between 0.0 and 1.0
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: ColorPalleteHelper.black,
                                    fontWeight: FontWeight.w700),
                          ),
                          Text(
                            dateTimeConverter(releaseDate: releaseDate),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorPalleteHelper.gray500,
                                    fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  overview,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        width: 44, // Set the desired width
                        height: 44, // Set the desired height
                        decoration: BoxDecoration(
                          color: ColorPalleteHelper.white, // Background color
                          shape: BoxShape.circle, // Circular shape
                          border: Border.all(
                            color: ColorPalleteHelper.gray500, // Outline color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 24,
                              Icons.star_rounded,
                              color: ColorPalleteHelper.gray500,
                            ),
                            // Icon color
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: 44, // Set the desired width
                        height: 44, // Set the desired height
                        decoration: BoxDecoration(
                          color: ColorPalleteHelper.pink, // Background color
                          shape: BoxShape.circle, // Circular shape
                          border: Border.all(
                            color: ColorPalleteHelper.pink, // Outline color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 24,
                              Icons.favorite_rounded,
                              color: ColorPalleteHelper.white,
                            ),
                            // Icon color
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: 44, // Set the desired width
                        height: 44, // Set the desired height
                        decoration: BoxDecoration(
                          color: ColorPalleteHelper.white, // Background color
                          shape: BoxShape.circle, // Circular shape
                          border: Border.all(
                            color: ColorPalleteHelper.gray500, // Outline color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 24,
                              Icons.close_rounded,
                              color: ColorPalleteHelper.gray500,
                            ),
                            // Icon color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),
    );
  }

  String dateTimeConverter({required String releaseDate}) {
    String dateString = releaseDate; // Original date string
    DateTime dateTime =
        DateTime.parse(dateString); // Convert to DateTime object

    // Format to "June 17, 1997"
    String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

    return formattedDate;
  }
}
