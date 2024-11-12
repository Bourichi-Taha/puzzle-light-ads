import 'package:puzzle/ad_manager/admob_ads/admob_ads.dart';
import 'package:puzzle/ad_manager/applovin_ads/applovin_ads.dart';
import 'package:puzzle/ad_manager/facebook_ads/facebook_ads.dart';
import 'package:puzzle/ad_manager/unity_ads/unity_ads.dart';
import 'package:puzzle/main.dart';

abstract class AppInterstitialAd {
  static int _clickCount = 0;

  static load() {
    switch (selectedAdNetwork) {
      case AdNetwork.admob:
        return AdMobInterstitialAd.load();
      case AdNetwork.facebook:
        return FBInterstitialAd.load();
      case AdNetwork.applovin:
        return AppLovinInterstitialAd.load();
      case AdNetwork.unity:
        return UnityInterstitialAd.load();
    }
  }

  static show() {
    if (++_clickCount >= 4) {
      _clickCount = 0;

      switch (selectedAdNetwork) {
        case AdNetwork.admob:
          return AdMobInterstitialAd.show();
        case AdNetwork.facebook:
          return FBInterstitialAd.show();
        case AdNetwork.applovin:
          return AppLovinInterstitialAd.show();
        case AdNetwork.unity:
          return UnityInterstitialAd.show();
      }
    }
  }
}
