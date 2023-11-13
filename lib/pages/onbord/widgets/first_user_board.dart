import 'package:flutter/material.dart';

import '../../../setting/colors.dart';

class UserBoard extends StatelessWidget {
  final String image;
  final String bigText;
  final String littleText;
  final Color boxColor;
  final bool isNotification;
  const UserBoard(
      {super.key,
      required this.image,
      required this.boxColor,
      required this.bigText,
      required this.isNotification,
      required this.littleText});

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 13;
    final fontSizeLittle = MediaQuery.of(context).size.width / 25;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.05,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: boxColor),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: image == 'assets/images/rating.png'
                      ? 1400 / 1700
                      : 234 / 390,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              !isNotification
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 55),
                      child: Align(
                        alignment: Alignment.center,
                        child: AspectRatio(
                            aspectRatio: 301 / 77,
                            child: Image.asset(
                              'assets/images/notific.png',
                            )),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  child: Material(
                color: Colors.transparent,
                child: Text(
                  bigText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700),
                ),
              )),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            littleText,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSizeLittle,
                color: fontColorLittle),
          ),
        ),
      ],
    );
  }
}
