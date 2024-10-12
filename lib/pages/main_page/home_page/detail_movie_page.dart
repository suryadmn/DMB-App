import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmb_app/datas/params/params_path.dart';
import 'package:dmb_app/providers/provider_home.dart';
import 'package:dmb_app/utils/flushbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../datas/networking/url_access.dart';
import '../../../utils/color_pallete_helper.dart';

class DetailMoviePage extends StatefulWidget {
  final dynamic dataParams;
  const DetailMoviePage({super.key, this.dataParams});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  ProviderHome? providerHome;

  bool isExpanded = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    providerHome = Provider.of<ProviderHome>(context, listen: false);

    if (widget.dataParams != null) {
      String movieId = widget.dataParams[ParamsPath.idMovieParam].toString();
      providerHome?.getDetailMovie(int.parse(movieId));
      providerHome?.getCredits(int.parse(movieId));
      providerHome?.getSimiliarMovie(int.parse(movieId));
    } else {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() {
        Navigator.pop(context);
        FlushbarHelper.show(
            context, 'Sorry, the movie detail your request was not found!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Provider.of<ProviderHome>(context).isLoadingDetailMovie
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      // borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "${UrlAccess.urlBaseMedia}${Provider.of<ProviderHome>(context).detailMovie.posterPath}",
                        ),
                        fit: BoxFit
                            .cover, // Ensures the image covers the entire container
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(
                              0.3), // Optional dark overlay for better readability
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 20),
                          child: Container(
                            width: 54, // Set the desired width
                            height: 54, // Set the desired height
                            decoration: BoxDecoration(
                              color: ColorPalleteHelper.gray500
                                  .withOpacity(0.5), // Background color
                              shape: BoxShape.circle, // Circular shape
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  size: 28,
                                  Icons.close_rounded,
                                  color: ColorPalleteHelper.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                // Shadow-like background for the title
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 2.0),
                                  color: Colors.black.withOpacity(
                                      0.5), // Semi-transparent background
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 8),
                                    child: Text(
                                      Provider.of<ProviderHome>(context)
                                              .detailMovie
                                              .title ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            color: ColorPalleteHelper.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            posterBodyText(
                              text: Provider.of<ProviderHome>(context)
                                      .detailMovie
                                      .overview ??
                                  "",
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Actors',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8.0),
                            TextButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text('SEE ALL'),
                                    SizedBox(width: 8.0),
                                    Icon(Icons.chevron_right_rounded)
                                  ],
                                ))
                          ],
                        ),
                        actorList(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8.0),
                          ],
                        ),
                        const SizedBox(height: 8),
                        information(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Similar Movie',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8.0),
                            TextButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text('SEE ALL'),
                                    SizedBox(width: 8.0),
                                    Icon(Icons.chevron_right_rounded)
                                  ],
                                ))
                          ],
                        ),
                        similiarMovieList(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget posterBodyText({required String text, required int maxLines}) {
    return Stack(
      children: [
        // Shadow-like background for the description
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          color: Colors.black.withOpacity(0.5), // Semi-transparent background
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isExpanded
                        ? text
                        : text.length > 100
                            ? '${text.substring(0, 100)}... '
                            : text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorPalleteHelper.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (text.length > 100)
                    TextSpan(
                      text: isExpanded ? "Read Less" : "Read More",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget actorList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<ProviderHome>(context).castList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              color: Colors.transparent,
              width: 100,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl:
                          "${UrlAccess.urlBaseMedia}${Provider.of<ProviderHome>(context).castList[index].profilePath ?? ""}",
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 44,
                          color: ColorPalleteHelper.error,
                        ),
                      ),
                      fit: BoxFit
                          .cover, // Ensures the image covers the CircleAvatar
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Provider.of<ProviderHome>(context).castList[index].name ??
                        "",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget information() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Release",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                dateTimeConverter(
                    releaseDate: Provider.of<ProviderHome>(context)
                            .detailMovie
                            .releaseDate ??
                        ""),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Vote",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                '${truncateAfterTwoDecimals(Provider.of<ProviderHome>(context).detailMovie.voteAverage ?? 0.0)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Language",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                Provider.of<ProviderHome>(context)
                    .detailMovie
                    .originalLanguage!
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Status",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                '${Provider.of<ProviderHome>(context).detailMovie.status}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Budget",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                convertToUSD(
                    Provider.of<ProviderHome>(context).detailMovie.budget ?? 0),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Genre",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 50),
                Text(
                  Provider.of<ProviderHome>(context)
                      .detailMovie
                      .genres!
                      .map((genre) => genre.name)
                      .join(', '),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  Widget similiarMovieList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            Provider.of<ProviderHome>(context).similiarMovieResult.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "${UrlAccess.urlBaseMedia}${Provider.of<ProviderHome>(context).similiarMovieResult[index].posterPath ?? ""}",
                  ),
                  fit: BoxFit
                      .cover, // Ensures the image covers the entire container
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(
                        0.3), // Optional dark overlay for better readability
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Provider.of<ProviderHome>(context)
                              .similiarMovieResult[index]
                              .title ??
                          "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: ColorPalleteHelper.white,
                              fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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

  double truncateAfterTwoDecimals(double value) {
    String stringValue = value
        .toStringAsFixed(4); // Keep 4 decimal places to handle the truncation
    List<String> parts = stringValue.split('.'); // Split by the decimal point

    if (parts.length > 1 && parts[1].length > 2) {
      parts[1] = parts[1]
          .substring(0, parts[1].length - 2); // Remove the last two digits
    }

    String truncatedValue = parts.join('.');
    return double.parse(truncatedValue);
  }

  String convertToUSD(int value) {
    final NumberFormat currencyFormatter =
        NumberFormat.currency(symbol: "\$ ", decimalDigits: 2);
    return currencyFormatter.format(value);
  }
}
