import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../setting/colors.dart';

class SecondBoard extends StatelessWidget {
  const SecondBoard({super.key});

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
                      child: Image.asset('assets/images/iphone_second.png'))),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Run your errands',
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

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
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
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.onboardIndicator != current.onboardIndicator,
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context
                          .read<HomeBloc>()
                          .add(OnboardIndicatorBackEvent(b: i));
                      },
                      child: SizedBox(
                        width: 20,
                        child: CircleAvatar(
                            radius: 5,
                            backgroundColor: state.onboardIndicator == i
                                ? containerColor
                                : disactiveIndicator),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
