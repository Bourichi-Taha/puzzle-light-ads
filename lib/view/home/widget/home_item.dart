import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Container homeItem(int index, String title, String image, Color color,
    int mission) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(10),
    height: 101,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 0),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      children: [
        Row(
          children: [
            Container(
              height: 73,
              width: 73,
              decoration: BoxDecoration(
                  color: colorOflevel(title.toLowerCase()).withOpacity(0.20),
                  shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  image,
                  height: 46,
                  width: 46,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.museoModerno(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.48,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Opacity(
                  opacity: 0.50,
                  child: Text(
                    '$mission missions',
                    style: GoogleFonts.barlow(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            //logic
          },
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    ),
  );
}

Color colorOflevel(String levle) {
  switch (levle) {
    case 'amateur':
      return const Color(0xffD34298);
    case 'beginner':
      return const Color(0xff04BA32);
    case 'trainee':
      return const Color(0xff44B3E6);
    case 'intellectual':
      return const Color(0xff7D2EC5);
    case 'talent':
      return const Color(0xffF2890A);
    case 'specialist':
      return const Color(0xffF8C713);
    default:
      return const Color(0xffFFD700);
  }
}
