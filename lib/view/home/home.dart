import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/banner_Ad.dart';
import 'package:puzzle/ad_manager/interstitial_ad.dart';
import 'package:puzzle/ad_manager/native_ad.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/colors_utils.dart';
import 'package:puzzle/utils/icons_constants.dart';
import 'package:puzzle/utils/utils.dart';
import 'package:puzzle/view/home/widget/home_item.dart';
import 'package:puzzle/view/level/level.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InAppReview inAppReview = InAppReview.instance;
  Future<void> requestReview() => inAppReview.requestReview();

  @override
  void initState() {
    super.initState();
    AppInterstitialAd.load();
  }

  @override
  Widget build(context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.800000011920929),
                  title: Text(
                    'Exit',
                    style: GoogleFonts.skranji(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to exit?',
                    style: GoogleFonts.skranji(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No',
                          style: GoogleFonts.skranji(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.skranji(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        requestReview();
                      },
                      child: Text(
                        'Rate Us',
                        style: GoogleFonts.skranji(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              });
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: const Color(0xffFFFCFC),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SafeArea(
                    bottom: false,
                    left: false,
                    right: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    value.data.appIcon.toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                value.data.appName.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.museoModerno(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.60,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: hexToColor(value.data.mainColor.toString()),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  appIcon(IconsConstants.coin, false, context, 16, 16,
                                      color: Colors.white),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      value.score.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.museoModerno(
                                        color: Colors.white,
                                        fontSize: value.score > 999
                                            ? 12
                                            : value.score > 99
                                                ? 14
                                                : 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                AppInterstitialAd.show();
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: Colors.black.withOpacity(0.07000000029802322),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Center(
                                  child: appIcon(IconsConstants.profile, false, context, 16, 16,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: value.data.puzzles?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            AppInterstitialAd.show();
                            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                              statusBarColor: colorOflevel(
                                      value.data.puzzles![index].level.toString().toLowerCase())
                                  .withOpacity(0.20),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LevelScreen(
                                    defficulty: getDifficult(index),
                                    title: value.data.puzzles![index].level.toString(),
                                    mission: value.data.puzzles![index].images!.length,
                                    image:
                                        'assets/images/${value.data.puzzles![index].level.toString().toLowerCase()}.png',
                                    color: colorOflevel(value.data.puzzles![index].level
                                            .toString()
                                            .toLowerCase())
                                        .withOpacity(0.20),
                                    missions: value.data.puzzles![index].images!,
                                  ),
                                ));
                          },
                          child: homeItem(
                            index,
                            value.data.puzzles![index].level.toString(),
                            'assets/images/${value.data.puzzles![index].level.toString().toLowerCase()}.png',
                            hexToColor(value.data.mainColor.toString()),
                            value.data.puzzles![index].images!.length,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return index == 0 ? const AppNativeAd() : Container();
                      },
                    ),
                  ),
                  const AppBannerAd(),
                ],
              ),
            )),
      ),
    );
  }
}

int getDifficult(int index) {
  return index + 3;
}
