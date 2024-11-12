import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/ad_manager/interstitial_ad.dart';
import 'package:puzzle/model_view/data_provider.dart';
import 'package:puzzle/utils/icons_constants.dart';
import 'package:puzzle/utils/utils.dart';
import 'package:puzzle/view/game/game.dart';

class LevelScreen extends StatefulWidget {
  final int defficulty;
  final String title;
  final int mission;
  final String image;
  final Color color;
  final List<String> missions;
  const LevelScreen(
      {super.key,
      required this.defficulty,
      required this.title,
      required this.mission,
      required this.image,
      required this.color,
      required this.missions});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 0),
      () async {
        Provider.of<DataProvider>(context, listen: false).getMissionDone();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: widget.color,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.title,
                                    style: GoogleFonts.museoModerno(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                  Text(
                                    '${widget.mission} missions',
                                    style: GoogleFonts.abel(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.48,
                                    ),
                                  ),
                                ],
                              ),
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
                                    color: Colors.black.withOpacity(0.07000000029802322),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: appIcon(IconsConstants.close, false, context, 16, 16,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  widget.image,
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.22,
                  left: 20,
                  right: 20,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: widget.missions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AppInterstitialAd.show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GameScreen(
                                  images: widget.missions,
                                  index: index,
                                  defficulty: widget.defficulty,
                                  color: widget.color,
                                  title: widget.title,
                                );
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff2BA25F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: value.missiondone.contains(widget.missions[index])
                                    ? Border.all(
                                        color: const Color(0xff2BA25F),
                                        width: 3,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(widget.missions[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            if (value.missiondone.contains(widget.missions[index]))
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2BA25F),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        appIcon(IconsConstants.coin, false, context, 14, 14),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '+${widget.defficulty * 100}',
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
