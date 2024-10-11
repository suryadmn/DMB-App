import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_auth.dart';
import '../../../providers/provider_home.dart';
import '../../../providers/provider_profile.dart';
import '../../../utils/shared_preferences_helper.dart';
import 'widgets/carousel_session.dart';
import 'widgets/now_playing_session.dart';
import 'widgets/popular_session.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProviderAuth? providerAuth;
  ProviderHome? providerHome;
  ProviderProfile? providerProfile;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    providerAuth = Provider.of<ProviderAuth>(context, listen: false);
    providerHome = Provider.of<ProviderHome>(context, listen: false);
    providerProfile = Provider.of<ProviderProfile>(context, listen: false);

    SharedPreferencesHelper.getSessionId(
            key: SharedPreferencesHelper.prefsSessionIdKey)
        .then((sessionIdValue) {
      if (sessionIdValue.isEmpty) {
        SharedPreferencesHelper.getToken(
                key: SharedPreferencesHelper.prefsTokenKey)
            .then((requestTokenValue) {
          if (requestTokenValue.isNotEmpty) {
            providerAuth
                ?.generateSessionId(requestToken: requestTokenValue)
                .then((generateSessionIdResponseValue) {
              SharedPreferencesHelper.setNewSSessionId(
                      sessionId: generateSessionIdResponseValue.sessionId ?? "")
                  .whenComplete(() {
                getAccountDetail().whenComplete(() {
                  getToprated();
                  getNowPlaying();
                  getPopular();
                  getWatchlist();
                  getFavourite();
                });
              });
            });
          }
        });
      } else {
        getAccountDetail().whenComplete(() {
          getToprated();
          getNowPlaying();
          getPopular();
          getWatchlist();
          getFavourite();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            initialize();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CarouselSession(),
                const SizedBox(height: 34.0),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      NowPlayingSession(
                        providerHome: providerHome!,
                        providerProfile: providerProfile!,
                      ),
                      const SizedBox(height: 24.0),
                      PopularSession(
                        providerHome: providerHome!,
                        providerProfile: providerProfile!,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getWatchlist() async {
    SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerProfile?.getWatclistMovie(accountId: accountIdValue);
    });
  }

  Future<void> getFavourite() async {
    SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerProfile?.getFavouriteMovie(accountId: accountIdValue);
    });
  }

  Future<void> getAccountDetail() async {
    await SharedPreferencesHelper.getAccountId(
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

  Future<void> getToprated() async {
    await SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerHome?.getTopRated(accountId: accountIdValue);
    });
  }

  Future<void> getNowPlaying() async {
    await SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerHome?.getNowPlaying(accountId: accountIdValue);
    });
  }

  Future<void> getPopular() async {
    await SharedPreferencesHelper.getAccountId(
            key: SharedPreferencesHelper.prefsAccountIdKey)
        .then((accountIdValue) {
      providerHome?.getPopular(accountId: accountIdValue);
    });
  }
}
