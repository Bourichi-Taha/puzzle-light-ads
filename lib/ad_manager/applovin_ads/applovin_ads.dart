import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

abstract class AppLovinInterstitialAd {
  static const _id = "26d512ea6876f2ec";

  static void load() {
    try {
      AppLovinMAX.loadInterstitial(_id);
    } catch (_) {}
  }

  static Future<void> show() async {
    if ((await AppLovinMAX.isInterstitialReady(_id)) == true) {
      try {
        AppLovinMAX.showInterstitial(_id);
        Future.delayed(const Duration(seconds: 10), () {
          load();
        });
      } catch (_) {}
    } else {
      load();
    }
  }
}

class AppLovinNativeAdWidget extends StatelessWidget {
  const AppLovinNativeAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxAdView(
      adUnitId: '9c887ce9aa106336',
      adFormat: AdFormat.mrec,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdClickedCallback: (ad) {},
        onAdExpandedCallback: (ad) {},
        onAdCollapsedCallback: (ad) {},
      ),
    );
  }
}

class AppLovinBannerAdWidget extends StatelessWidget {
  const AppLovinBannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxAdView(
      adUnitId: '727ca3a0e2d391e8',
      adFormat: AdFormat.banner,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdClickedCallback: (ad) {},
        onAdExpandedCallback: (ad) {},
        onAdCollapsedCallback: (ad) {},
      ),
    );
  }
}
