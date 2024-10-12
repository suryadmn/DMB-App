import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmb_app/datas/routes/route_name.dart';
import 'package:dmb_app/utils/flushbar_helper.dart';
import 'package:dmb_app/utils/snackbar_helper.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../datas/networking/url_access.dart';
import '../../../../datas/params/params_path.dart';
import '../../../../providers/provider_home.dart';
import '../../../../providers/provider_profile.dart';
import '../../../../utils/color_pallete_helper.dart';
import '../../../../utils/shared_preferences_helper.dart';
import '../../../../widgets/shimmer_widget.dart';

class NowPlayingSession extends StatefulWidget {
  final ProviderProfile providerProfile;
  final ProviderHome providerHome;
  const NowPlayingSession(
      {super.key, required this.providerHome, required this.providerProfile});

  @override
  State<NowPlayingSession> createState() => _NowPlayingSessionState();
}

class _NowPlayingSessionState extends State<NowPlayingSession> {
  List<int> watchlistIdTmp = [];
  List<int> favouriteIdTmp = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Now Playing',
              style: Theme.of(context).textTheme.headlineMedium,
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
        const SizedBox(height: 8.0),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: Provider.of<ProviderHome>(context).isLoadingNowPlaying
                ? 3
                : Provider.of<ProviderHome>(context).nowPlayingResult.length > 6
                    ? 6
                    : Provider.of<ProviderHome>(context)
                        .nowPlayingResult
                        .length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Provider.of<ProviderHome>(context).isLoadingNowPlaying
                    ? ShimmerWidget.rectangular(
                        height: 300.0,
                        width: 200.0,
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, detailMovieRoute,
                              arguments: {
                                ParamsPath.idMovieParam:
                                    Provider.of<ProviderHome>(context,
                                                listen: false)
                                            .nowPlayingResult[index]
                                            .id ??
                                        0
                              });
                        },
                        child: Container(
                          width: 200.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                "${UrlAccess.urlBaseMedia}${Provider.of<ProviderHome>(context).nowPlayingResult[index].posterPath ?? ""}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Row(
                                      children: [
                                        Container(
                                          width: 44, // Set the desired width
                                          height: 44, // Set the desired height
                                          decoration: BoxDecoration(
                                            color: ColorPalleteHelper
                                                .white, // Background color
                                            shape: BoxShape
                                                .circle, // Circular shape
                                            border: Border.all(
                                              color: ColorPalleteHelper
                                                  .white, // Outline color
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                List<int> toAdd =
                                                    []; // Temporary list to hold elements to add

                                                if (watchlistIdTmp.isNotEmpty) {
                                                  for (var element
                                                      in watchlistIdTmp) {
                                                    if (element !=
                                                        Provider.of<ProviderHome>(
                                                                context,
                                                                listen: false)
                                                            .nowPlayingResult[
                                                                index]
                                                            .id) {
                                                      toAdd.add(Provider.of<
                                                                      ProviderHome>(
                                                                  context,
                                                                  listen: false)
                                                              .nowPlayingResult[
                                                                  index]
                                                              .id ??
                                                          0);
                                                    }
                                                  }
                                                } else {
                                                  toAdd.add(
                                                      Provider.of<ProviderHome>(
                                                                  context,
                                                                  listen: false)
                                                              .nowPlayingResult[
                                                                  index]
                                                              .id ??
                                                          0);
                                                }

                                                watchlistIdTmp.addAll(toAdd);

                                                setState(() {});

                                                addWatchlist(
                                                    movieId: Provider.of<
                                                                    ProviderHome>(
                                                                context,
                                                                listen: false)
                                                            .nowPlayingResult[
                                                                index]
                                                            .id ??
                                                        0);
                                              },
                                              icon: Icon(
                                                size: 24,
                                                Icons.bookmark_rounded,
                                                color:
                                                    Provider.of<ProviderProfile>(
                                                                    context)
                                                                .movieListResult
                                                                .any(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      Provider.of<ProviderHome>(
                                                                              context)
                                                                          .nowPlayingResult[
                                                                              index]
                                                                          .id,
                                                                ) ||
                                                            watchlistIdTmp.any(
                                                              (element) =>
                                                                  element ==
                                                                  Provider.of<ProviderHome>(
                                                                          context)
                                                                      .nowPlayingResult[
                                                                          index]
                                                                      .id,
                                                            )
                                                        ? ColorPalleteHelper
                                                            .primary500
                                                        : ColorPalleteHelper
                                                            .gray500,
                                              ),
                                              // Icon color
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          width: 44, // Set the desired width
                                          height: 44, // Set the desired height
                                          decoration: BoxDecoration(
                                            color: ColorPalleteHelper
                                                .white, // Background color
                                            shape: BoxShape
                                                .circle, // Circular shape
                                            border: Border.all(
                                              color: ColorPalleteHelper
                                                  .white, // Outline color
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                List<int> toAdd =
                                                    []; // Temporary list to hold elements to add

                                                if (favouriteIdTmp.isNotEmpty) {
                                                  for (var element
                                                      in favouriteIdTmp) {
                                                    if (element !=
                                                        Provider.of<ProviderHome>(
                                                                context,
                                                                listen: false)
                                                            .nowPlayingResult[
                                                                index]
                                                            .id) {
                                                      toAdd.add(Provider.of<
                                                                      ProviderHome>(
                                                                  context,
                                                                  listen: false)
                                                              .nowPlayingResult[
                                                                  index]
                                                              .id ??
                                                          0);
                                                    }
                                                  }
                                                } else {
                                                  toAdd.add(
                                                      Provider.of<ProviderHome>(
                                                                  context,
                                                                  listen: false)
                                                              .nowPlayingResult[
                                                                  index]
                                                              .id ??
                                                          0);
                                                }

                                                favouriteIdTmp.addAll(toAdd);

                                                setState(() {});

                                                addFavourite(
                                                    movieId: Provider.of<
                                                                    ProviderHome>(
                                                                context,
                                                                listen: false)
                                                            .nowPlayingResult[
                                                                index]
                                                            .id ??
                                                        0);
                                              },
                                              icon: Icon(
                                                size: 24,
                                                Icons.favorite_rounded,
                                                color: Provider.of<ProviderProfile>(
                                                                context)
                                                            .favouriteMovieResult
                                                            .any(
                                                              (element) =>
                                                                  element.id ==
                                                                  Provider.of<ProviderHome>(
                                                                          context)
                                                                      .nowPlayingResult[
                                                                          index]
                                                                      .id,
                                                            ) ||
                                                        favouriteIdTmp.any(
                                                          (element) =>
                                                              element ==
                                                              Provider.of<ProviderHome>(
                                                                      context)
                                                                  .nowPlayingResult[
                                                                      index]
                                                                  .id,
                                                        )
                                                    ? ColorPalleteHelper.pink
                                                    : ColorPalleteHelper
                                                        .gray500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          width: 44, // Set the desired width
                                          height: 44, // Set the desired height
                                          decoration: BoxDecoration(
                                            color: ColorPalleteHelper
                                                .white, // Background color
                                            shape: BoxShape
                                                .circle, // Circular shape
                                            border: Border.all(
                                              color: ColorPalleteHelper
                                                  .white, // Outline color
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                if (Provider.of<ProviderHome>(
                                                        context,
                                                        listen: false)
                                                    .isLoadingDownloadImage) {
                                                  FlushbarHelper.show(
                                                    context,
                                                    'Downloading still progress!',
                                                    status: 'w',
                                                  );
                                                } else {
                                                  widget.providerHome
                                                      .downloadAndSaveImageToStorage(
                                                          context,
                                                          Provider.of<ProviderHome>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .nowPlayingResult[
                                                                      index]
                                                                  .posterPath ??
                                                              "");
                                                }
                                              },
                                              icon: const Icon(
                                                size: 24,
                                                Icons.download_rounded,
                                                color:
                                                    ColorPalleteHelper.success,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  Provider.of<ProviderHome>(context)
                                          .nowPlayingResult[index]
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
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> addWatchlist({required int movieId}) async {
    await SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      widget.providerProfile
          .addWatchlistMovie(accountId: accountIdValue, movieId: movieId)
          .then((addWatchlistResponsevalue) {
        if (addWatchlistResponsevalue.statusCode == 1) {
          SnackbarHelper.show(
            context,
            "Successfully added to watchlist",
            backgroundColor: Theme.of(context).primaryColor,
            textColor: ColorPalleteHelper.white,
          );
        }
      });
    });
  }

  Future<void> addFavourite({required int movieId}) async {
    await SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      widget.providerProfile
          .addFavouriteMovie(accountId: accountIdValue, movieId: movieId)
          .then((addWatchlistResponsevalue) {
        if (addWatchlistResponsevalue.statusCode == 1) {
          SnackbarHelper.show(
            context,
            "Successfully added to favourite",
            backgroundColor: Theme.of(context).primaryColor,
            textColor: ColorPalleteHelper.white,
          );
        }
      });
    });
  }
}
