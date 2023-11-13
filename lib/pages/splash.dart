import 'dart:async';

import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SplashPage());
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double end = 0;
  double start = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 10), (tick) {
      if (tick.tick == 110) {
        tick.cancel();
        MyNavigatorManager.instance.firstPush();
      }
      start = end;
      end = tick.tick / 100;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: splashBackgroundColor,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 219),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          const SizedBox(height: 350),
          LoadingIndicator(
            key: ValueKey('$end'),
            begin: start,
            end: end,
          )
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatefulWidget {
  final double begin;
  final double end;
  const LoadingIndicator({super.key, required this.begin, required this.end});
  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  @override
  void initState() {
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late Animation anime =
      Tween<double>(begin: widget.begin, end: widget.end).animate(controller);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anime,
      builder: (context, w) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: LinearProgressIndicator(
            value: widget.end * anime.value,
            color: loaderColor,
            backgroundColor: loaderBackgroundColor,
          ),
        );
      },
    );
  }
}
