import 'package:bin_trade/pages/history.dart';
import 'package:bin_trade/pages/news.dart';
import 'package:bin_trade/pages/progress.dart';
import 'package:bin_trade/pages/simulator.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../widget/drawer.dart';

class HomePage extends StatefulWidget {
  static const String routeNamed = '/home';
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: HomePage.routeNamed),
      pageBuilder: (context, _, __) => const HomePage(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100));
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SlideTransition(
            position:
                Tween<Offset>(begin: Offset.zero, end: const Offset(0.7, 0))
                    .animate(controller),
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: appBarColor,
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => controller.isCompleted
                            ? controller.reverse()
                            : controller.forward(),
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                          color: menuButtonColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) =>
                            previous.homePageIndex != current.homePageIndex,
                        builder: (context, state) {
                          return Text(
                            menuIcons.keys.toList()[state.homePageIndex],
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.homePageIndex != current.homePageIndex,
                builder: (context, state) {
                  return IndexedStack(
                    index: state.homePageIndex,
                    children: const [
                      HistoryPage(),
                      SimulatorPage(),
                      ProgressPage(),
                      NewsPage()
                    ],
                  );
                },
              ),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(-1, 0), end: const Offset(0, 0))
                .animate(controller),
            child: MenuWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
