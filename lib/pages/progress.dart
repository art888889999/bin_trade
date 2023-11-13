// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bin_trade/pages/achiev_history.dart';
import 'package:bin_trade/pages/history.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:bin_trade/setting/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bin_trade/setting/colors.dart';

import '../bloc/home/home_bloc.dart';
import '../models/order.dart';
import '../widget/pop_up.dart';

class ProgressPage extends StatelessWidget {
  static const String routeName = '/progress';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const ProgressPage());
  }

  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == MyStatus.win || state.status == MyStatus.lose) {
          showWinPop(context, state.history.last);
        }
        if (state.status == MyStatus.zero) {
          showAlertPop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressBox(),
            const SizedBox(height: 10),
            const Text(
              'Achievements',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              child: const AchevBuilder(),
            )
          ],
        ),
      ),
    );
  }
}

class AchevBuilder extends StatelessWidget {
  const AchevBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 175 / 92,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        return BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.history != current.history,
          builder: (context, state) {
            final text = achievData.keys.toList()[index];

            return AchievBox(
                all: achievData.values.toList()[index][1],
                points: achievData.values.toList()[index][0],
                done: state.mainGet(text).length,
                text: text,
                orders: state.mainGet(text),
                price: [state.p_100, state.p_200, state.p_500, state.p_1000]);
          },
        );
      },
    );
  }
}

class AchievBox extends StatelessWidget {
  final String text;
  final int all;
  final int points;
  final int done;
  final List<int> price;
  bool get isDone {
    switch (text) {
      case 'Bidding for \$100':
        return price[0] >= all;
      case 'Bidding for \$200':
        return price[1] >= all;
      case 'Bidding for \$500':
        return price[2] >= all;
      case 'Bidding for \$1000':
        return price[3] >= all;
      default:
        return all == done;
    }
  }

  bool get isPrice {
    if (text == 'Bidding for \$100' ||
        text == 'Bidding for \$200' ||
        text == 'Bidding for \$500' ||
        text == 'Bidding for \$1000') {
      return true;
    } else {
      return false;
    }
  }

  int get myPrice {
    switch (text) {
      case 'Bidding for \$100':
        return price[0];
      case 'Bidding for \$200':
        return price[1];
      case 'Bidding for \$500':
        return price[2];
      case 'Bidding for \$1000':
        return price[3];
      default:
        return 0;
    }
  }

  final List<MyOrder> orders;
  const AchievBox({
    Key? key,
    required this.points,
    required this.text,
    required this.price,
    required this.orders,
    required this.all,
    required this.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {
            MyNavigatorManager.instance.achievPush(MyAchiev(
                isDone: isDone,
                text: text,
                all: all,
                points: points,
                done: done,
                price: myPrice,
                orders: orders));
          },
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                    colors: !isDone
                        ? [menuItemBackgroundColor, menuItemBackgroundColor]
                        : [const Color(0xFFF8D000), const Color(0xFFD19319)])),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: isDone ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 20),
                  isDone
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '${isPrice ? myPrice : done} / $all ${isPrice ? 'points' : 'deals'}',
                            style: TextStyle(
                                color: isDone ? Colors.black : menuIconsColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                  isDone
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                '${orders.last.date.day.monthNum}.${orders.last.date.month.monthNum}.${orders.last.date.year.monthNum}',
                                style: TextStyle(
                                    color:
                                        isDone ? Colors.black : menuIconsColor,
                                    fontSize: 12),
                              )),
                              Text('$points points',
                                  style: TextStyle(
                                      color: isDone
                                          ? Colors.black
                                          : menuIconsColor,
                                      fontSize: 12))
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: !isPrice ? done / all : myPrice / all,
                              color: loaderColor,
                              backgroundColor: loaderBackgroundColor,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressBox extends StatelessWidget {
  const ProgressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 358 / 107,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: menuItemBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.allPrice != current.allPrice,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        const Text(
                          'Level: ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${state.pointLevel[0]}',
                          style: const TextStyle(
                              color: containerColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      '${state.allPrice} / ${state.pointLevel[1]}',
                      style: const TextStyle(
                          color: menuIconsColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: state.allPrice / state.pointLevel[1],
                          color: loaderColor,
                          backgroundColor: loaderBackgroundColor,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
