import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/banner_Ad.dart';
import 'package:puzzle/model_view/data_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => const Scaffold(
        body: SizedBox(
          child: AppBannerAd(),
          // child: Stack(
          //   children: [
          //
          //     Align(
          //       alignment: Alignment.topCenter,
          //       child: SizedBox(
          //         height: MediaQuery.of(context).size.height / 1.7,
          //         child: PageView(
          //           controller: controller,
          //           children: [
          //             for (var i = 0; i < value.data.intro!.length; i++)
          //               onboardingItem(context, value, i),
          //           ],
          //           onPageChanged: (int index) {
          //             setState(() {
          //               currentPage = index;
          //             });
          //           },
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: SizedBox(
          //         height: MediaQuery.of(context).size.height / 2.6,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             indicatorItems(value, currentPage),
          //             const SizedBox(height: 27),
          //             Text(
          //               value.data.intro![currentPage].title.toString(),
          //               maxLines: 1,
          //               textAlign: TextAlign.center,
          //               overflow: TextOverflow.ellipsis,
          //               style: GoogleFonts.abel(
          //                 color: const Color(0xFF27214D),
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.w400,
          //                 letterSpacing: -0.24,
          //               ),
          //             ),
          //             const SizedBox(height: 10),
          //             Opacity(
          //               opacity: 0.60,
          //               child: Text(
          //                 value.data.intro![currentPage].description.toString(),
          //                 textAlign: TextAlign.center,
          //                 maxLines: 2,
          //                 style: const TextStyle(
          //                   color: Color(0xFF5C577E),
          //                   fontSize: 16,
          //                   fontFamily: 'Abel',
          //                   fontWeight: FontWeight.w400,
          //                   letterSpacing: -0.16,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: SizedBox(
          //         height: 100,
          //         child: Column(
          //           children: [
          //             // if (currentPage == 0)
          //             InkWell(
          //               borderRadius: BorderRadius.circular(100),
          //               onTap: () {
          //                 if (currentPage == value.data.intro!.length - 1) {
          //                   Navigator.pushReplacementNamed(context, '/home');
          //                 }
          //                 if (currentPage < value.data.intro!.length - 1) {
          //                   controller.nextPage(
          //                     duration: const Duration(milliseconds: 500),
          //                     curve: Curves.easeIn,
          //                   );
          //                 }
          //               },
          //               child: Container(
          //                 width: 70,
          //                 height: 70,
          //                 decoration: ShapeDecoration(
          //                   color: hexToColor(value.data.mainColor.toString())
          //                       .withOpacity(0.2),
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(100),
          //                   ),
          //                 ),
          //                 child: Center(
          //                   child: Container(
          //                     height: 60,
          //                     width: 60,
          //                     decoration: ShapeDecoration(
          //                       color:
          //                           hexToColor(value.data.mainColor.toString()),
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(100),
          //                       ),
          //                     ),
          //                     child: Image.asset(
          //                       ImageConstants.star,
          //                       height: 27,
          //                       width: 27,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
