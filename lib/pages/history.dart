import 'package:bin_trade/models/order.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.activeOrders.values.length !=
              current.activeOrders.values.length ||
          previous.historyPageIndex != current.historyPageIndex,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      color: state.historyPageIndex == 0
                          ? containerColor
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () => context
                            .read<HomeBloc>()
                            .add(const ChangeHistoryPageIndex(index: 0)),
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              'Current',
                              style: TextStyle(
                                  color: state.historyPageIndex == 0
                                      ? Colors.black
                                      : menuIconsColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      color: state.historyPageIndex == 1
                          ? containerColor
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () => context
                            .read<HomeBloc>()
                            .add(const ChangeHistoryPageIndex(index: 1)),
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              'Finished',
                              style: TextStyle(
                                  color: state.historyPageIndex == 1
                                      ? Colors.black
                                      : menuIconsColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 180,
              child: IndexedStack(
                index: state.historyPageIndex,
                children: const [ActiveHistory(), DisactiveHistory()],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.activeOrders.values.length !=
          current.activeOrders.values.length,
      builder: (context, state) {
        if (state.activeOrders.values.isEmpty) {
          return const HistroryEpty();
        }
        return SingleChildScrollView(
          child: Column(children: [
            for (var i = 0; i < state.activeOrders.values.length; i++)
              Builder(builder: (context) {
                final order = state.activeOrders.values.toList()[i];
                return Column(
                  children: [
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
                                        borderRadius: BorderRadius.circular(5),
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
                                    state.activeOrders.values
                                        .toList()[i]
                                        .valute,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                  Text(
                                    '\$${order.price}',
                                    style: const TextStyle(color: Colors.white),
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
                                    'Left:',
                                    style: TextStyle(color: menuIconsColor),
                                  ),
                                  const SizedBox(width: 3),
                                  LeftTimer(
                                    key: ValueKey(order.myId),
                                    order: order,
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'Deal time:',
                                    style: TextStyle(color: menuIconsColor),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    order.dealTimeString,
                                    style: const TextStyle(color: Colors.white),
                                  )
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
          ]),
        );
      },
    );
  }
}

class LeftTimer extends StatefulWidget {
  const LeftTimer({
    super.key,
    required this.order,
  });

  final MyOrder order;

  @override
  State<LeftTimer> createState() => _LeftTimerState();
}

class _LeftTimerState extends State<LeftTimer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.order.timerSubstruct(),
        builder: (context, snap) {
          if (!snap.hasData) return const SizedBox.shrink();
          return Text(
            snap.data ?? '00:00',
            style: const TextStyle(color: containerColor),
          );
        });
  }
}

class DisactiveHistory extends StatelessWidget {
  const DisactiveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.history.length != current.history.length,
      builder: (context, state) {
        if (state.history.isEmpty) {
          return const HistroryEpty();
        }
        return ListView.separated(
            itemCount: state.history.length,
            separatorBuilder: (context, index) {
              if (index == 0) return const SizedBox.shrink();
              if (state.history[index].date.day !=
                      state.history[index - 1].date.day ||
                  state.history[index].date.month !=
                      state.history[index - 1].date.month) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${state.history[index].date.month.monthString}  ${state.history[index].date.day}',
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
              final order = state.history[index];
              final isWon = order.status == MyStatus.win;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${state.history[index].date.month.monthString}  ${state.history[index].date.day}',
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
                                      borderRadius: BorderRadius.circular(5),
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
                                flags[order.valute] ?? const SizedBox.shrink(),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  order.valute,
                                  style: const TextStyle(color: Colors.white),
                                )),
                                Text(
                                  '${isWon ? '+' : '-'}\$${order.price}',
                                  style: TextStyle(
                                      color: isWon ? Colors.green : Colors.red),
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
                                  style: const TextStyle(color: Colors.white),
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
            });
      },
    );
  }
}

class HistroryEpty extends StatelessWidget {
  const HistroryEpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty.png',
          width: 50,
        ),
        const SizedBox(height: 30),
        const Text(
          'There are no History',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Text(
          'Start trading on our simulator',
          style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 38,
          width: 108,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: containerColor),
            child: const Text(
              'Trade',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              context.read<HomeBloc>().add(const HomeChangePageIndex(index: 1));
            },
          ),
        ),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}

extension Months on int {
  String get monthString {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'November';
    }
  }
}

extension MonthsNum on int {
  String get monthNum {
    switch (this) {
      case 1:
        return '01';
      case 2:
        return '02';
      case 3:
        return '03';
      case 4:
        return '04';
      case 5:
        return '05';
      case 6:
        return '06';
      case 7:
        return '07';
      case 8:
        return '08';
      case 9:
        return '09';
      case 2023:
        return '23';
      case 2024:
        return '24';
      default:
        return '$this';
    }
  }
}
