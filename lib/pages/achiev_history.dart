// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bin_trade/pages/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/home/home_bloc.dart';
import '../models/order.dart';
import '../setting/colors.dart';
import '../setting/strings.dart';

class AchievHistory extends StatelessWidget {
  static const String routeName = '/achiev';
  static Route route(MyAchiev achiev) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => AchievHistory(
              achiev: achiev,
            ));
  }

  final MyAchiev achiev;

  const AchievHistory({super.key, required this.achiev});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: menuItemBackgroundColor,
          middle: Text(
            'Achievement',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          previousPageTitle: 'Back',
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 358 / 193,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                        colors: !achiev.isDone
                            ? [menuItemBackgroundColor, menuItemBackgroundColor]
                            : [
                                const Color(0xFFF8D000),
                                const Color(0xFFD19319)
                              ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Name',
                          style: TextStyle(
                              color: achiev.isDone
                                  ? menuIconsColor
                                  : menuIconsColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          achiev.text,
                          style: TextStyle(
                              color:
                                  achiev.isDone ? Colors.black : Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 20),
                      achiev.isDone ? const Spacer() : const SizedBox.shrink(),
                      achiev.isDone
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                '${achiev.isPrice ? achiev.price : achiev.done} / ${achiev.all} ${achiev.isPrice ? 'points' : 'deals'}',
                                style: TextStyle(
                                    color: achiev.isDone
                                        ? Colors.black
                                        : menuIconsColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                      achiev.isDone
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '${achiev.orders.last.date.day} ${achiev.orders.last.date.month.monthString} ${achiev.orders.last.date.year}',
                                    style: TextStyle(
                                        color: achiev.isDone
                                            ? Colors.black
                                            : menuIconsColor,
                                        fontSize: 17),
                                  )),
                                  Text('${achiev.points} points',
                                      style: TextStyle(
                                          color: achiev.isDone
                                              ? Colors.black
                                              : menuIconsColor,
                                          fontSize: 17))
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  value: !achiev.isPrice
                                      ? achiev.done / achiev.all
                                      : achiev.price / achiev.all,
                                  color: loaderColor,
                                  backgroundColor: loaderBackgroundColor,
                                ),
                              ),
                            ),
                      achiev.isDone ? const SizedBox() : const Spacer(),
                      achiev.isDone
                          ? const SizedBox()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Reward',
                                style: TextStyle(color: menuIconsColor),
                              ),
                            ),
                      achiev.isDone
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 5),
                              child: Text(
                                '${achiev.points} points',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: achiev.orders.length,
                  separatorBuilder: (context, index) {
                    if (index == 0) return const SizedBox.shrink();
                    if (achiev.orders[index].date.day !=
                            achiev.orders[index - 1].date.day ||
                        achiev.orders[index].date.month !=
                            achiev.orders[index - 1].date.month) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${achiev.orders[index].date.month.monthString}  ${achiev.orders[index].date.day}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  itemBuilder: (context, index) {
                    final order = achiev.orders[index];
                    final isWon = order.status == MyStatus.win;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              '${achiev.orders[index].date.month.monthString}  ${achiev.orders[index].date.day}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        SizedBox(
                          height: 90,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: menuItemBackgroundColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: order.promise
                                                ? Colors.green
                                                : Colors.red),
                                        child: Center(
                                          child: order.promise
                                              ? const Icon(
                                                  Icons.arrow_upward,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.black,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      flags[order.valute] ??
                                          const SizedBox.shrink(),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        order.valute,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      Text(
                                        '${isWon ? '+' : '-'}\$${order.price}',
                                        style: TextStyle(
                                            color: isWon
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: menuIconsColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Invested:',
                                        style: TextStyle(color: menuIconsColor),
                                      ),
                                      Text(
                                        ' \$${order.price}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),
            ),
          ],
        ));
  }
}

class MyAchiev {
  final bool isDone;
  final String text;
  final int all;
  final int points;
  final int done;
  final int price;
  final List<MyOrder> orders;
  MyAchiev({
    required this.isDone,
    required this.text,
    required this.all,
    required this.points,
    required this.done,
    required this.price,
    required this.orders,
  });
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
}
