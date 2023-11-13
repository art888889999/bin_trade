import 'package:flutter/material.dart';

import '../../../setting/colors.dart';

class FirstBoard extends StatelessWidget {
  const FirstBoard({super.key});

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
                  margin: const EdgeInsets.only(bottom: 2),
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: containerColor),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                      aspectRatio: 936 / 1600,
                      child: Image.asset('assets/images/iphone_first.png'))),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Practice on our simulator',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700),
              )),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'in our app',
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
