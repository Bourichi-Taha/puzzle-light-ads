import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdMobInterstitialAd {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  static void load() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ad unit ID
      request: const AdRequest(), // No need for testDevices here
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true; // Set the flag when the ad is loaded
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isAdLoaded = false; // Reset the flag if loading fails
        },
      ),
    );
  }

  static Future<void> show() async {
    if (_isAdLoaded && _interstitialAd != null) {
      try {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            _isAdLoaded = false;
            _interstitialAd = null;
            load();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            _isAdLoaded = false;
            _interstitialAd = null;
            load();
          },
        );
        await _interstitialAd!.show();
      } catch (e) {
        _isAdLoaded = false;
        _interstitialAd = null;
        load();
      }
    }
  }
}

enum AdStates { loading, loaded, error }

class AdMobNativeAdWidget extends StatefulWidget {
  const AdMobNativeAdWidget({
    super.key,
    this.id = 'ca-app-pub-3940256099942544/2247696110',
    this.templateType = TemplateType.medium,
  });

  final String id;
  final TemplateType templateType;

  @override
  State<AdMobNativeAdWidget> createState() => _AdMobNativeAdWidgetState();
}

class _AdMobNativeAdWidgetState extends State<AdMobNativeAdWidget> {
  ValueNotifier<AdStates> adState = ValueNotifier<AdStates>(AdStates.loading);

  NativeAd? _ad;

  void loadAd() async {
    NativeAd(
      adUnitId: widget.id,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _ad = ad as NativeAd;
          adState.value = AdStates.loaded;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          adState.value = AdStates.error;
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: widget.templateType,
        mainBackgroundColor: Colors.white,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            backgroundColor: Colors.blue,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            backgroundColor: Colors.white,
            style: NativeTemplateFontStyle.italic,
            size: 16.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            backgroundColor: Colors.white,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            backgroundColor: Colors.white,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
      ),
    ).load();

    Future.delayed(const Duration(seconds: 7), () {
      if (adState.value != AdStates.loaded) {
        adState.value = AdStates.error;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      if (widget.id.isEmpty) throw Exception('Ad unit id is empty');
      loadAd();
    } catch (_) {
      adState.value = AdStates.error;
    }
  }

  @override
  void dispose() {
    try {
      _ad?.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: adState,
      builder: (context, state, _) {
        return state == AdStates.error
            ? const SizedBox.shrink()
            : Container(
                height: widget.templateType == TemplateType.medium ? 300 : 120,
                decoration: const BoxDecoration(color: Colors.white),
                width: double.infinity,
                child: Center(
                  child: state == AdStates.loaded
                      ? AdWidget(ad: _ad!)
                      : const CircularProgressIndicator(color: Colors.blue),
                ),
              );
      },
    );
  }
}

class AdMobBannerAdWidget extends StatefulWidget {
  const AdMobBannerAdWidget({super.key});

  @override
  State<AdMobBannerAdWidget> createState() => _AdMobBannerAdWidgetState();
}

class _AdMobBannerAdWidgetState extends State<AdMobBannerAdWidget> {
  BannerAd? _ad;
  final ValueNotifier<AdStates> adState = ValueNotifier<AdStates>(AdStates.loading);

  void loadAd() {
    _ad = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          adState.value = AdStates.loaded;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          adState.value = AdStates.error;
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
        onAdImpression: (ad) {},
        onAdClicked: (ad) {},
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    try {
      loadAd();
    } catch (_) {}
  }

  @override
  void dispose() {
    try {
      _ad?.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: adState,
      builder: (context, state, _) {
        return state == AdStates.error
            ? const SizedBox.shrink()
            : SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: state == AdStates.loaded
                      ? AdWidget(ad: _ad!)
                      : const CircularProgressIndicator(color: Colors.blue),
                ),
              );
      },
    );
  }
}
