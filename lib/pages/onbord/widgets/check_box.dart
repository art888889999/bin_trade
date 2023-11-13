import 'package:flutter/material.dart';

import '../../../setting/colors.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  int b = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 2; i++)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    b = i;
                    setState(() {});
                  },
                  child: CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          b == i ? containerColor : disactiveIndicator),
                ),
                const SizedBox(width: 8),
              ],
            ),
        ],
      ),
    );
  }
}
