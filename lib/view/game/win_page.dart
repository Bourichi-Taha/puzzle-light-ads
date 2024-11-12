import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/interstitial_ad.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/image_constants.dart';

class WinPage extends StatefulWidget {
  const WinPage({super.key});

  @override
  State<WinPage> createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  final controller = ConfettiController();
  Color color = Colors.white;
  @override
  void initState() {
    super.initState();
    controller.play();
    color = getrandomColor();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: color.withOpacity(0.60),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.60),
                    image: DecorationImage(
                        image: AssetImage(value.data.cover.toString()), fit: BoxFit.fill),
                    // gradient: LinearGradient(
                    //   begin: const Alignment(0.00, -2.00),
                    //   end: const Alignment(0, 1),
                    //   colors: [
                    //     color.withOpacity(0.60),
                    //     Colors.white,
                    //     color.withOpacity(0.60),
                    //     color.withOpacity(0.60)
                    //   ],
                    // ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.60),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        // height: 150,
                        // width: 150,
                        child: Image(
                          // height: 150,
                          // width: 150,
                          fit: BoxFit.fill,
                          image: AssetImage(ImageConstants.confetti),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                            width: 150,
                            child: Image(
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                              image: AssetImage(ImageConstants.win),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Congratulations',
                            textAlign: TextAlign.center,
                            //  style: TextStyle(
                            //    color: Colors.white,
                            //    fontSize: 48,
                            //    fontFamily: 'Stylish',
                            //    fontWeight: FontWeight.w400,
                            //    height: 0,
                            //    letterSpacing: 1.44,
                            //  ),
                            style: GoogleFonts.stylish(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.44,
                            ),
                          ),
                          Opacity(
                            opacity: 0.80,
                            child: Text(
                              'You unlocked new badge!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.54,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [

                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      // Suggested code may be subject to a license. Learn more: ~LicenseLog:2976003058.
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: InkWell(
                            onTap: () {
                              AppInterstitialAd.show();
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 47,
                              decoration: ShapeDecoration(
                                color: color.withOpacity(0.75),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 3,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Colors.white.withOpacity(0.15000000596046448),
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Go to the next Challenge',
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            AppInterstitialAd.show();
                            Navigator.pop(context, false);
                          },
                          child: Opacity(
                            opacity: 0.70,
                            child: Text(
                              'Dismiss',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.48,
                              ),
                            ),
                          ),
                        ),
                        ConfettiWidget(
                          confettiController: controller,
                          shouldLoop: true,
                          blastDirectionality: BlastDirectionality.explosive,
                          emissionFrequency: 0.00,
                          numberOfParticles: 2000,
                          minBlastForce: 100,
                          maxBlastForce: 1000,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

Color getrandomColor() {
  List<Color> colors = [const Color(0xff00FFF0), const Color(0xffFFD600), const Color(0xffFF4455)];
  Random random = Random();
  return colors[random.nextInt(colors.length)];
}
