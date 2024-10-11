import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../datas/routes/route_name.dart';
import '../../../providers/provider_auth.dart';
import '../../../providers/provider_profile.dart';
import '../../../utils/color_pallete_helper.dart';
import '../../../utils/shared_preferences_helper.dart';
import '../../../widgets/shimmer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProviderProfile? providerProfile;
  ProviderAuth? providerAuth;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    providerProfile = Provider.of<ProviderProfile>(context, listen: false);
    providerAuth = Provider.of<ProviderAuth>(context, listen: false);

    getAccountDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Provider.of<ProviderProfile>(context).isLoadingGetDetailAccount
                    ? const ShimmerWidget.circular(
                        height: 160,
                        width: 160,
                      )
                    : CircleAvatar(
                        radius: 80,
                        child: Provider.of<ProviderProfile>(context)
                                    .accountDetailResponse
                                    .avatar
                                    ?.tmdb
                                    ?.avatarPath ==
                                null
                            ? Text(
                                "${Provider.of<ProviderProfile>(context).accountDetailResponse.username?.substring(0, 1)}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 70),
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      Provider.of<ProviderProfile>(context)
                                          .accountDetailResponse
                                          .avatar
                                          ?.tmdb
                                          ?.avatarPath,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit
                                      .cover, // Ensures the image covers the CircleAvatar
                                ),
                              ),
                      ),
                const SizedBox(height: 16),
                Provider.of<ProviderProfile>(context).isLoadingGetDetailAccount
                    ? ShimmerWidget.rectangular(
                        height: 34,
                        width: 100,
                      )
                    : Text(
                        "${Provider.of<ProviderProfile>(context).accountDetailResponse.name ?? Provider.of<ProviderProfile>(context).accountDetailResponse.username}",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                const SizedBox(height: 24),
                Provider.of<ProviderProfile>(context).isLoadingGetDetailAccount
                    ? ShimmerWidget.rectangular(
                        height: 54,
                      )
                    : Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.movie_creation_rounded,
                            color: ColorPalleteHelper.primary500,
                          ),
                          title: Text(
                            'Watchlist Movie',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: ColorPalleteHelper.primary500,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, watchlistMovieRoute);
                          },
                        ),
                      ),
                const SizedBox(height: 8),
                Provider.of<ProviderProfile>(context).isLoadingGetDetailAccount
                    ? ShimmerWidget.rectangular(
                        height: 54,
                      )
                    : Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.favorite_rounded,
                            color: ColorPalleteHelper.primary500,
                          ),
                          title: Text(
                            'Favorite Movie',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: ColorPalleteHelper.primary500,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, favouriteMovieRoute);
                          },
                        ),
                      ),
                const SizedBox(height: 8),
                Provider.of<ProviderProfile>(context).isLoadingGetDetailAccount
                    ? ShimmerWidget.rectangular(
                        height: 54,
                      )
                    : Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout_rounded,
                            color: ColorPalleteHelper.primary500,
                          ),
                          title: Text(
                            'Logout',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onTap: () {
                            SharedPreferencesHelper.getSessionId(
                                    key: SharedPreferencesHelper
                                        .prefsSessionIdKey)
                                .then((sessionIdValue) {
                              if (sessionIdValue.isNotEmpty) {
                                providerAuth
                                    ?.sessionLogout(sessionId: sessionIdValue)
                                    .then((value) {
                                  Navigator.pushReplacementNamed(
                                      context, loginRoute);
                                });
                              }
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAccountDetail() async {
    SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      if (accountIdValue == 0) {
        providerProfile?.getAccountDetail().then((accountDetailResponseValue) {
          SharedPreferencesHelper.setAccountId(
              accountId: accountDetailResponseValue.id ?? 0);
        });
      } else {
        providerProfile
            ?.getAccountDetail(accountId: accountIdValue)
            .then((accountDetailResponseValue) {
          SharedPreferencesHelper.setAccountId(
              accountId: accountDetailResponseValue.id ?? 0);
        });
      }
    });
  }

  // Center(
  //       child: TextButton(
  //           onPressed: () {
  //             SharedPreferencesHelper.getSessionId(
  //                     key: SharedPreferencesHelper.prefsSessionIdKey)
  //                 .then((sessionIdValue) {
  //               if (sessionIdValue.isEmpty) {
  //                 providerAuth
  //                     ?.sessionLogout(sessionId: sessionIdValue)
  //                     .then((value) {
  //                   Navigator.pushReplacementNamed(context, loginRoute);
  //                 });
  //               }
  //             });
  //           },
  //           child: Text('Logout')),
  //     ),
}
