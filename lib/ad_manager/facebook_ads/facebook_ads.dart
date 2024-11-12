import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

abstract class FBInterstitialAd {
  static bool _isAdLoaded = false;

  static void load() {
    try {
      FacebookAudienceNetwork.loadInterstitialAd(
        placementId: "1256390695793858_1256391729127088",
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            _isAdLoaded = true;
          } else if (result == InterstitialAdResult.ERROR) {
            _isAdLoaded = false;
            FacebookAudienceNetwork.destroyInterstitialAd();
            load();
          } else if (result == InterstitialAdResult.DISMISSED) {
            FacebookAudienceNetwork.destroyInterstitialAd();
            load();
          }
        },
      );
    } catch (e) {
      FacebookAudienceNetwork.destroyInterstitialAd();
      load();
    }
  }

  static void show() {
    if (_isAdLoaded) {
      FacebookAudienceNetwork.showInterstitialAd(delay: 1);
    } else {
      print("Interstitial ad not loaded");
    }
  }
}

class FBNativeAdWidget extends StatelessWidget {
  const FBNativeAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FacebookNativeAd(
        placementId: "1256390695793858_1256391839127077",
        adType: NativeAdType.NATIVE_AD,
        width: double.infinity,
        height: 300,
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        descriptionColor: Colors.white,
        buttonColor: Colors.deepPurple,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.white,
        keepAlive: true, //set true if you do not want adview to refresh on widget rebuild
        keepExpandedWhileLoading:
            false, // set false if you want to collapse the native ad view when the ad is loading
        expandAnimationDuraion:
            300, //in milliseconds. Expands the adview with animation when ad is loaded
        listener: (result, value) {},
      ),
    );
  }
}

class FBBannerAdWidget extends StatelessWidget {
  const FBBannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FacebookBannerAd(
      placementId: "1256390695793858_1256391625793765",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            break;
          case BannerAdResult.LOADED:
            break;
          case BannerAdResult.CLICKED:
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            break;
        }
      },
    );
  }
}
