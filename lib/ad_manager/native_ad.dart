import 'package:flutter/material.dart';
import 'package:puzzle/ad_manager/admob_ads/admob_ads.dart';
import 'package:puzzle/ad_manager/applovin_ads/applovin_ads.dart';
import 'package:puzzle/ad_manager/facebook_ads/facebook_ads.dart';
import 'package:puzzle/main.dart';

class AppNativeAd extends StatelessWidget {
  const AppNativeAd({super.key});

  @override
  Widget build(BuildContext context) {
    switch (selectedAdNetwork) {
      case AdNetwork.admob:
        return const AdMobNativeAdWidget();
      case AdNetwork.facebook:
        return const FBNativeAdWidget();
      case AdNetwork.applovin:
        return const AppLovinNativeAdWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
