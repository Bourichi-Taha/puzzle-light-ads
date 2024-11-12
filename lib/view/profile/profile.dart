import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/interstitial_ad.dart';
import 'package:puzzle/main.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/icons_constants.dart';
import 'package:puzzle/utils/utils.dart';
import 'package:puzzle/view/profile/webview.dart';
import 'package:puzzle/view/profile/widgets/builder_item.dart';
import 'package:puzzle/view/profile/widgets/profile_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final InAppReview inAppReview = InAppReview.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> openStoreListing() => inAppReview.openStoreListing(
        appStoreId: packageInfo!.packageName,
        microsoftStoreId: packageInfo!.packageName,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color(0xffFEFBFB)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffFEFBFB)),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            AppInterstitialAd.show();
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: appIcon(IconsConstants.close, false, context, 16, 16,
                                    color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 111,
                              width: 111,
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(value.data.appIcon.toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    BorderedText(
                      strokeColor: Colors.white.withOpacity(0.15000000596046448),
                      child: Text(
                        value.data.appName.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.museoModerno(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.70,
                          child: Text(
                            'Support us',
                            style: GoogleFonts.museoModerno(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    profileItem(context, 'Rate Us', IconsConstants.rateus, () {
                      openStoreListing();
                      // _requestReview();
                    }),
                    profileItem(context, 'Contact Us', IconsConstants.contact, () {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: value.data.contact,
                        query: encodeQueryParameters(<String, String>{
                          'subject': 'Feedback',
                        }),
                      );
                      launchUrl(emailLaunchUri);
                    }),
                    profileItem(context, 'Share with friends', IconsConstants.share, () {
                      if (Platform.isIOS) {
                        Share.share(
                            'https://apps.apple.com/us/app/${packageInfo!.packageName}/id${packageInfo!.buildSignature}');
                      } else {
                        Share.share(
                            'https://play.google.com/store/apps/details?id=${packageInfo!.packageName}');
                      }
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.70,
                          child: Text(
                            'About the app',
                            style: GoogleFonts.museoModerno(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    profileItem(context, 'About us', IconsConstants.aboutus, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WebviewScreen(url: value.data.about!, title: 'About us');
                      }));
                    }),
                    profileItem(context, 'Terms and Conditions', IconsConstants.trems, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WebviewScreen(url: value.data.terms!, title: 'Terms and Conditions');
                      }));
                    }),
                    profileItem(context, 'Privacy Policy', IconsConstants.privacy, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WebviewScreen(url: value.data.privacy!, title: 'Privacy Policy');
                      }));
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    builderWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
