import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/pages/onbord/widgets/first_user_board.dart';
import 'package:bin_trade/pages/onbord/widgets/second_board.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../setting/colors.dart';

void main() {
  runApp(const CupertinoApp(
    home: UsrOutBoard(),
  ));
}

class UsrOutBoard extends StatefulWidget {
  const UsrOutBoard({super.key});

  @override
  State<UsrOutBoard> createState() => _UsrOutBoardState();
}

class _UsrOutBoardState extends State<UsrOutBoard>
    with TickerProviderStateMixin {
  late final AnimationController contr = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 250));
  @override
  Widget build(BuildContext context) {
    final horizontal = MediaQuery.of(context).size.width / 20;
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 8.2,
            bottom: MediaQuery.of(context).size.height / 18,
            right: horizontal,
            left: horizontal),
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.onboardIndicator != current.onboardIndicator,
          listener: (context, state) {
            if (state.onboardIndicator == 1) {
              contr.forward();
            } else {
              contr.reverse();
            }
          },
          child: Column(
            children: [
              Stack(
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                            begin: Offset.zero, end: const Offset(-1.5, 0))
                        .animate(contr),
                    child: const UserBoard(
                      bigText: 'Practice on our simulator',
                      littleText: 'in our app',
                      image: 'assets/images/iphone_first.png',
                      boxColor: containerColor,
                      isNotification: false,
                    ),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(1.5, 0), end: Offset.zero)
                        .animate(contr),
                    child: const UserBoard(
                      bigText: 'Run your errands',
                      littleText: 'in our app',
                      image: 'assets/images/iphone_second.png',
                      boxColor: containerColor,
                      isNotification: false,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const MyCheckBox(),
              SizedBox(height: MediaQuery.of(context).size.height / 42),
              SizedBox(
                height: MediaQuery.of(context).size.height / 17.5,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!contr.isCompleted) {
                      contr.forward();
                      context.read<HomeBloc>().add(OnboardIndicatorOutEvent());
                    } else {
                      MyNavigatorManager.instance.simulatorPush();
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: containerColor),
                  child: const Text(
                    'Next',
                    style:
                        TextStyle(fontSize: 16, color: scaffoldBackgroundColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
