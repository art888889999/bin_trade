import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../setting/strings.dart';

class MenuWidget extends StatelessWidget {
  final AnimationController controller;
  const MenuWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
              child: Column(
                children: [
                  const UserWidget(),
                  const SizedBox(height: 20),
                  BaseMenu(
                    controller: controller,
                  ),
                  const SizedBox(height: 20),
                  const AdditinalMenu()
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.reverse(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height,
              child: ColoredBox(color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

class AdditinalMenu extends StatefulWidget {
  const AdditinalMenu({
    super.key,
  });

  @override
  State<AdditinalMenu> createState() => _AdditinalMenuState();
}

class _AdditinalMenuState extends State<AdditinalMenu> {
  final InAppReview inAppReview = InAppReview.instance;
  void launchPolicy() async {
    final uri = Uri.parse(
        'https://docs.google.com/document/d/1uaRn9ftb5t1L0Z4mh_8IM_jjfx2PHPxG76Dpr2cFkek/edit?usp=sharing');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: menuItemBackgroundColor),
      child: Column(
        children: [
          for (var i = 4; i <= 6; i++)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  i == 4 ? inAppReview.requestReview() : null;
                  i == 5
                      ? Share.share('check out my website https://example.com',
                          subject: appName)
                      : null;
                  i == 6 ? launchPolicy() : null;
                },
                child: SizedBox(
                  height: 48,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          menuIcons.keys.toList()[i],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: menuIconsColor,
                      )
                    ]),
                  ),
                ),
              ),
            ),
          const Divider(
            height: 1,
            color: menuIconsColor,
          )
        ],
      ),
    );
  }
}

class BaseMenu extends StatelessWidget {
  final AnimationController controller;
  const BaseMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: menuItemBackgroundColor),
      child: Column(
        children: [
          for (var i = 0; i <= 3; i++)
            Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<HomeBloc>()
                          .add(HomeChangePageIndex(index: i));
                      controller.reverse();
                    },
                    child: SizedBox(
                      height: 48,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(children: [
                          menuIcons.values.toList()[i],
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            menuIcons.keys.toList()[i],
                            style: const TextStyle(color: Colors.white),
                          )),
                          const Icon(
                            Icons.navigate_next,
                            color: menuIconsColor,
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
                i > 2
                    ? const SizedBox.shrink()
                    : const Divider(
                        height: 1,
                        color: menuIconsColor,
                      )
              ],
            ),
        ],
      ),
    );
  }
}

final Map<String, Image> menuIcons = {
  'History': Image.asset(
    'assets/images/history.png',
    width: 24,
  ),
  'Simulator': Image.asset(
    'assets/images/simulator.png',
    width: 24,
  ),
  'Progress': Image.asset(
    'assets/images/progress.png',
    width: 24,
  ),
  'News': Image.asset(
    'assets/images/news.png',
    width: 24,
  ),
  'Rate the app': Image.asset(
    'assets/images/history.png',
    width: 24,
  ),
  'Share app': Image.asset(
    'assets/images/history.png',
    width: 24,
  ),
  'Usage Policy': Image.asset(
    'assets/images/history.png',
    width: 24,
  ),
};

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: menuItemBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.user?.image != current.user?.image,
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: state.user?.image,
                    backgroundColor: menuUserNotFoundColor,
                    child: const SizedBox.shrink(),
                  );
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.user?.name ?? 'Enter your name...',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                '${state.user?.points ?? 12000}',
                                style: const TextStyle(
                                    color: menuIconsColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () => MyNavigatorManager.instance.editPush(),
                child: const Icon(
                  Icons.settings,
                  color: menuIconsColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
