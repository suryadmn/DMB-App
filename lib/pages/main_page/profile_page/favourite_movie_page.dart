import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_profile.dart';
import '../../../utils/shared_preferences_helper.dart';
import '../../../widgets/shimmer_widget.dart';
import 'widgets/favourite_movie_card.dart';

class FavouriteMoviePage extends StatefulWidget {
  const FavouriteMoviePage({super.key});

  @override
  State<FavouriteMoviePage> createState() => _FavouriteMoviePageState();
}

class _FavouriteMoviePageState extends State<FavouriteMoviePage> {
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
      providerProfile?.getFavouriteMovie(accountId: accountIdValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Movie',
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
          itemCount:
              Provider.of<ProviderProfile>(context).isLoadingFavouriteMovie
                  ? 3
                  : Provider.of<ProviderProfile>(context)
                      .favouriteMovieResult
                      .length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child:
                  Provider.of<ProviderProfile>(context).isLoadingFavouriteMovie
                      ? cardShimmerLoading()
                      : FavouriteMovieCard(
                          imagePath: Provider.of<ProviderProfile>(context)
                                  .favouriteMovieResult[index]
                                  .posterPath ??
                              "",
                          title: Provider.of<ProviderProfile>(context)
                                  .favouriteMovieResult[index]
                                  .title ??
                              "",
                          voteAverage: Provider.of<ProviderProfile>(context)
                                  .favouriteMovieResult[index]
                                  .voteAverage ??
                              0.0,
                          releaseDate: Provider.of<ProviderProfile>(context)
                                  .favouriteMovieResult[index]
                                  .releaseDate ??
                              "",
                          overview: Provider.of<ProviderProfile>(context)
                                  .favouriteMovieResult[index]
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
    return ShimmerWidget.rectangular(height: 240);
  }
}
