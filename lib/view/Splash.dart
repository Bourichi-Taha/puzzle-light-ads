import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzle/main.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/colors_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        if (mounted) {
          if (!firstTime) {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/onboarding', (route) => false);
            }
          } else {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(value.data.cover.toString()),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: Text(
                    value.data.appName.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.museoModerno(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 4.48,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.00, 1.00),
                      end: const Alignment(0, -1),
                      colors: [
                        Colors.black,
                        Colors.black.withOpacity(0.5325443744659424),
                        Colors.black.withOpacity(0)
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 48, right: 48),
                        child: LinearProgressIndicator(
                          minHeight: 7,
                          borderRadius: BorderRadius.circular(50),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              hexToColor(value.data.mainColor.toString())),
                          backgroundColor:
                              Colors.white.withOpacity(0.15000000596046448),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please wait, we are loading...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.17,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
