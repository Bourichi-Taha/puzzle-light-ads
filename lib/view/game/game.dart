// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jigsaw_puzzle/flutter_jigsaw_puzzle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/interstitial_ad.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/colors_utils.dart';
import 'package:puzzle/utils/icons_constants.dart';
import 'package:puzzle/utils/utils.dart';
import 'package:puzzle/view/game/win_page.dart';

class GameScreen extends StatefulWidget {
  final int defficulty;
  final int index;
  final Color color;
  final String title;
  final List<String> images;

  const GameScreen({
    super.key,
    required this.images,
    required this.defficulty,
    required this.index,
    required this.color,
    required this.title,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selectedindex = 0;
  bool play = false;
  bool next = true;
  List<GlobalKey<JigsawWidgetState>> keys = [];
  late PageController pagecontroller;

  @override
  void initState() {
    super.initState();
    keys = List.generate(widget.images.length, (index) => GlobalKey<JigsawWidgetState>());
    pagecontroller = PageController(initialPage: widget.index);
    selectedindex = widget.index;

    Future.delayed(const Duration(milliseconds: 200), () {
      if (keys[widget.index].currentState != null) {
        keys[widget.index].currentState!.generate();
      }

      setState(() {
        play = true;
      });
    });
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: widget.color,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: widget.color,
        body: Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      Container(
                        color: widget.color,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amteur',
                                  style: GoogleFonts.museoModerno(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                                if (next)
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
                                        color: Colors.black.withOpacity(0.20),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: appIcon(
                                          IconsConstants.close,
                                          false,
                                          context,
                                          16,
                                          16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      left: 20,
                      right: 20,
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: pagecontroller,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.images.length,
                            onPageChanged: (value) {
                              setState(() {
                                selectedindex = value;
                              });
                              keys[selectedindex].currentState?.reset();
                              keys[selectedindex].currentState?.generate();
                            },
                            itemBuilder: (context, i) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: JigsawPuzzle(
                                  gridSize: widget.defficulty,
                                  image: AssetImage(widget.images[selectedindex]),
                                  onFinished: () async {
                                    value.incrementScore(widget.defficulty);
                                    value.setMissionDone(widget.images[i]);
                                    bool? shouldGoToNext = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const WinPage(),
                                      ),
                                    );
                                    if (shouldGoToNext == true) {
                                      if (selectedindex < widget.images.length - 1) {
                                        setState(() {
                                          selectedindex++;
                                        });
                                        pagecontroller.nextPage(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeIn,
                                        );
                                      } else {
                                        if (mounted) {
                                          Navigator.pop(context, false);
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        next = false;
                                      });
                                    }
                                  },
                                  snapSensitivity: .5,
                                  puzzleKey: keys[i],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (!play)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LinearProgressIndicator(
                      minHeight: 7,
                      borderRadius: BorderRadius.circular(50),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        hexToColor(value.data.mainColor.toString()),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.15),
                    ),
                  ),
                if (!play)
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                  ),
                if (!next) dimiss(context, value),
                Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
                    child: showImage(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container dimiss(BuildContext context, DataProvider value) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: appIcon(
                            IconsConstants.close,
                            false,
                            context,
                            16,
                            16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (selectedindex < widget.images.length - 1) {
                    setState(() {
                      selectedindex++;
                      next = true;
                    });
                    pagecontroller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.pop(context, false);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: hexToColor(value.data.mainColor.toString()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Go to Next Challenge',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.museoModerno(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding showImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            showDialog(
              barrierColor: Colors.black.withOpacity(0.8),
              context: context,
              builder: (context) => ImageDialog(
                image: widget.images[selectedindex],
              ),
            );
          },
          child: Container(
            width: 104,
            height: 104,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(widget.images[selectedindex]),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 30,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//dailog to show image
class ImageDialog extends StatelessWidget {
  final String image;

  const ImageDialog({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
