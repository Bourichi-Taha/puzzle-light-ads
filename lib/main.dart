import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/model/data.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/view/Splash.dart';
import 'package:puzzle/view/brand.dart';
import 'package:puzzle/view/home/home.dart';
import 'package:puzzle/view/onboarding/onboarding.dart';
import 'package:puzzle/view/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';


enum AdNetwork { admob, facebook, unity, applovin }

AdNetwork selectedAdNetwork = AdNetwork.facebook;

//this for package info
PackageInfo? packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
);

Data data = Data();
bool firstTime = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Future.wait([
      MobileAds.instance.initialize(),
      FacebookAudienceNetwork.init(
        testingId: "bfe47acb-dd50-43d6-8d3c-a65f0a6cee42",
      ),
      UnityAds.init(
        gameId: "5712423",
        testMode: true,
        onComplete: () {},
        onFailed: (error, message) {},
      ),
    ]);
    packageInfo = await PackageInfo.fromPlatform();
    //read json file from assets
    final json = await rootBundle.loadString('assets/db.json');
    final config = jsonDecode(json);
    data = Data.fromJson(config);

    //camera permission
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstTime = (prefs.getBool('isfirsttime') ?? false);
    if (!firstTime) {
      prefs.setBool('isfirsttime', true);
    }
  } catch (_) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: const Color(0xffFFFCFC),
          useMaterial3: true,
        ),
        initialRoute: '/brand',
        routes: {
          '/': (context) => const SplashScreen(),
          '/brand': (context) => const BrandScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/profile': (context) => const Profile(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
