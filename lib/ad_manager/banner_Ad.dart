import 'package:flutter/material.dart';
import 'package:puzzle/ad_manager/admob_ads/admob_ads.dart';
import 'package:puzzle/ad_manager/applovin_ads/applovin_ads.dart';
import 'package:puzzle/ad_manager/facebook_ads/facebook_ads.dart';
import 'package:puzzle/ad_manager/unity_ads/unity_ads.dart';
import 'package:puzzle/main.dart';

class AppBannerAd extends StatelessWidget {
  const AppBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    switch (selectedAdNetwork) {
      case AdNetwork.admob:
        return const AdMobBannerAdWidget();
      case AdNetwork.facebook:
        return const FBBannerAdWidget();
      case AdNetwork.applovin:
        return const AppLovinBannerAdWidget();
      case AdNetwork.unity:
        return const UnityBannerAdWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
