import 'package:dmb_app/providers/provider_profile.dart';
import 'package:dmb_app/utils/shared_preferences_helper.dart';
import 'package:dmb_app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/watchlist_movie_card.dart';

class WatchlistMoviePage extends StatefulWidget {
  const WatchlistMoviePage({super.key});

  @override
  State<WatchlistMoviePage> createState() => _WatchlistMoviePageState();
}

class _WatchlistMoviePageState extends State<WatchlistMoviePage> {
  ProviderProfile? providerProfile;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    providerProfile = Provider.of<ProviderProfile>(context, listen: false);

    SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerProfile?.getWatclistMovie(accountId: accountIdValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Watchlist Movie',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          initialize();
        },
        child: ListView.builder(
          itemCount: Provider.of<ProviderProfile>(context)
                  .isLoadingWatchListMovie
              ? 3
              : Provider.of<ProviderProfile>(context).movieListResult.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child:
                  Provider.of<ProviderProfile>(context).isLoadingWatchListMovie
                      ? cardShimmerLoading()
                      : WatchlistMovieCard(
                          imagePath: Provider.of<ProviderProfile>(context)
                                  .movieListResult[index]
                                  .posterPath ??
                              "",
                          title: Provider.of<ProviderProfile>(context)
                                  .movieListResult[index]
                                  .title ??
                              "",
                          voteAverage: Provider.of<ProviderProfile>(context)
                                  .movieListResult[index]
                                  .voteAverage ??
                              0.0,
                          releaseDate: Provider.of<ProviderProfile>(context)
                                  .movieListResult[index]
                                  .releaseDate ??
                              "",
                          overview: Provider.of<ProviderProfile>(context)
                                  .movieListResult[index]
                                  .overview ??
                              "",
                        ),
            );
          },
        ),
      ),
    );
  }

  Widget cardShimmerLoading() {
    return ShimmerWidget.rectangular(height: 220);
  }
}
