import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apstore.dart';
import '../bloc/home/home_bloc.dart';
import '../widget/drop_ios.dart';
import '../widget/sale_stock.dart';

class SimulatorPage extends StatefulWidget {
  static const String routeName = '/simulator';
  static Route route() {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SimulatorPage());
  }

  const SimulatorPage({super.key});

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isWorker != current.isWorker,
      builder: (context, state) {
        if (!state.isWorker) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty.png',
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'No bidding is currently underway!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }
        return ColoredBox(
          color: simulatorBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Stack(
                      children: [
                        const SizedBox(
                          child: ChartsWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: CupertinoPickerExample(
                              color: menuItemBackgroundColor,
                              values: valute,
                              textColor: menuIconsColor,
                              size: MediaQuery.of(context).size.width * 0.4),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: ColoredBox(
                    color: simulatorBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(children: [
                        const SizedBox(height: 10),
                        const SaleStock(),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: menuIconsColor),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_card_sharp,
                                    color: containerColor,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Your balance:',
                                    style: TextStyle(
                                        color: menuIconsColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 5),
                                  BlocBuilder<HomeBloc, HomeState>(
                                    buildWhen: (previous, current) =>
                                        previous.user?.points !=
                                        current.user?.points,
                                    builder: (context, state) {
                                      return Text(
                                        '${state.user?.points ?? 0} points',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoPickerExample(
                              color: simulatorButtonColor,
                              values: timeOrder,
                              textColor: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.47,
                            ),
                            const Spacer(),
                            CupertinoPickerExample(
                              color: simulatorButtonColor,
                              values: moneyOrder,
                              textColor: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.47,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SimulatorOrders(
                              text: 'up',
                              color: simulatorGreenButtonColor,
                              widget: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            SimulatorOrders(
                              text: 'down',
                              color: simulatorRedButtonColor,
                              widget: Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SimulatorOrders extends StatelessWidget {
  const SimulatorOrders(
      {super.key,
      required this.color,
      required this.widget,
      required this.text});

  final Color color;
  final Widget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.order.time != current.order.time,
      builder: (context, state) {
        final isA = state.order.time == '00:00';
        return Material(
          borderRadius: BorderRadius.circular(4),
          color: color,
          child: InkWell(
            onTap: () {
              isA
                  ? null
                  : context
                      .read<HomeBloc>()
                      .add(AddOrderEvent(value: text == 'up'));
            },
            child: SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.47,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          text.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: widget,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showDialogStartOrder(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return const SizedBox(
            child: Center(child: Text('Please set a time!')),
          );
        });
  }
}
